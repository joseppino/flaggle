<script lang="ts">
    import countriesData from "$lib/countriesData";
    import selectRandomCountry from "$lib/selectRandomCountry";
    import AutoComplete from "simple-svelte-autocomplete";

    // convert country names into uppercase for consistency
    const countries = countriesData.map(country => country = {...country, name: country.name.toUpperCase()});
    const countryNames: string[] = countriesData.map(country => country.name.toUpperCase());
    
    let country: any = selectRandomCountry();
    let selectedCountryObject: any;
    let attempts: number = 0;
</script>

<main>
    <h1>Flaggle</h1>
    <h4>A flag guessing game</h4>
    <img class="pure-img flag-image" src={`https://flagpedia.net/data/flags/h120/${country.code.toLowerCase()}.webp`} alt="?">
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
        {:else}
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9d1b1b;"></i> 
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9d1b1b;"></i>
            <i class="attempt-cross fa-solid fa-square-xmark fa-2xl" style="color: #9d1b1b;"></i>
        {/if}
    </div>
    <br>
    <div class="input-container">
        <AutoComplete items="{countries}" bind:selectedItem="{selectedCountryObject}" labelFieldName="name" />
        <button class="pure-button" on:click={() => {
            if(countryNames.includes(selectedCountryObject.name)) {
                selectedCountryObject.name === country.name.toUpperCase() ? alert("Correct") : attempts += 1;
            }
        }}>GUESS</button>
    </div>
</main>

<style>
    main {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .flag-image {
        width: 250px;
        border: 1px solid black;
    }

    .input-container {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    button {
        width: 200px;
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
