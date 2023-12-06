<script lang="ts">
    let country: any = {name: 'Latvia', code: 'LV'};
</script>

<main>
    <h1>Flaggle</h1>
    <h4>A flag guessing game</h4>
    <img class="flag-image" src={`https://flagpedia.net/data/flags/h120/${country.code.toLowerCase()}.webp`} alt="">
</main>

<style>
    .flag-image {
        max-width: 150px;
    }
</style>
