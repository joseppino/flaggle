<script lang="ts">
    import countriesData from "$lib/countriesData";
    import selectRandomCountry from "$lib/selectRandomCountry";
    //@ts-ignore
    import AutoComplete from "simple-svelte-autocomplete";
    import { onMount } from "svelte";
    import toast, { Toaster } from "svelte-french-toast";

    let guessInput: AutoComplete;
    let guessBtn: HTMLButtonElement;
    let input: HTMLInputElement;
    let surrenderBtn: HTMLButtonElement;

    // convert country names into uppercase for consistency
    const countries = countriesData.map(country => country = {...country, name: country.name.toUpperCase()});
    const countryNames: string[] = countriesData.map(country => country.name.toUpperCase());
    
    let loaded: boolean = false;
    let country: any = selectRandomCountry();
    let selectedCountryObject: any;
    let guessed: any[] = [];
    let attempts: number = 0;
    let surrenderClicks: number = 0;
    let gameOver: boolean = false;

    $: if(attempts === 3) { notifyLose(); }

    $: if(surrenderClicks === 1) { 
        surrenderBtn.innerText = "REALLY?";
        setTimeout(() => {
            surrenderClicks = 0;
            surrenderBtn.innerText = "GIVE UP?";
        }, 2000);
    }

    $: if(surrenderClicks === 2) { attempts = 3; }

    function notifyWin() {
        toast.success(
            "Correct!",
            {
                duration: 10000,
                style: 'border-radius: 100px; color: var(--colour4);'
            }
        );
        endGame();
    }

    function notifyLose() {
        toast.error(
            `${country.name.toUpperCase()}`,
            {
                duration: 30000,
                style: 'border-radius: 100px; color: var(--colour4);'
            }
        );
        endGame();
    }

    function endGame() {
        guessBtn.classList.add("pure-button-disabled");
        if(input != null) {
            input.disabled = true;
        }
        guessBtn.disabled = true;
        gameOver = true;
    }

    // delay flag load by ~half a second due to odd loading behaviour
    onMount(() => {
        //@ts-ignore
        input = document.querySelector("input");
        setTimeout(() => {
            loaded = true;
        }, 600);
    })
</script>

<Toaster />
<main>
    <h1>Flaggle</h1>
    {#if loaded}
        <img class="pure-img flag-image" src={`https://flagpedia.net/data/flags/h240/${country.code.toLowerCase()}.webp`} alt="?">
    {:else}
        <p>Loading...</p>
    {/if}
    <p>ATTEMPTS</p>
    <div class="attempts">
        {#if attempts === 0}
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9c9c9c;"></i>
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9c9c9c;"></i>
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9c9c9c;"></i>
        {:else if attempts === 1}
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9d1b1b;"></i>
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9c9c9c;"></i>
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9c9c9c;"></i>
        {:else if attempts === 2}
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9d1b1b;"></i>
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9d1b1b;"></i>
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9c9c9c;"></i>
        {:else if attempts > 2}
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9d1b1b;"></i> 
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9d1b1b;"></i>
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9d1b1b;"></i>
        {/if}
    </div>
    <br>
    <div class="input-container">
        <AutoComplete items="{countries}"
        bind:this={guessInput}
        bind:selectedItem="{selectedCountryObject}"
        labelFieldName="name"
        hideArrow="true"/>
        <button class="pure-button"
        bind:this={guessBtn}
        on:click={() => {
            if(guessed.includes(selectedCountryObject.name)) {
                toast('Already guessed!', {
                    icon: '⚠️',
                    style: 'border-radius: 100px; background: var(--colour5); color: var(--colour4);'
                });
            } else {
                if(countryNames.includes(selectedCountryObject.name)) {
                    if(selectedCountryObject.name === country.name.toUpperCase()) {
                        notifyWin();
                    } else {
                        attempts += 1;
                        guessed.push(selectedCountryObject.name);
                        
                    }
                }
            }
        }}>GUESS</button>
    </div>
    {#if !gameOver}
        <button
        bind:this={surrenderBtn}
        class="pure-button"
        style="background-color: rgba(230, 65, 65, 0.7)"
        on:click={() => surrenderClicks += 1}
        >GIVE UP?</button>
    {/if}
    {#if gameOver}
        <button
        class="pure-button"
        style="background-color: var(--colour2);"
        on:click={() => window.location.reload()}>
        AGAIN?</button>
    {/if}
</main>

<style>
    main {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 600px;
        max-width: 95vw;
        background-color: var(--colour1);
        height: 99vh;
        min-height: 500px;
        box-shadow: 10px -2px 4px var(--colour3);
        margin-top: 5px;
        color: var(--colour4);
    }

    .flag-image {
        width: 250px;
        border: 1px solid black;
    }

    .input-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-top: 20px;
    }

    button {
        width: 200px;
        margin-top: 10px;
        background-color: var(--colour5);
    }

    .attempts {
        display: flex;
        flex-direction: row;
        margin-left: 10px;
    }

    .attempt-cross {
        margin-right: 10px;
    }
</style>
