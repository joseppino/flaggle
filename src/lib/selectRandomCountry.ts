import countriesData from "$lib/countriesData";

export default function() {
    const shortlist = countriesData;
    return shortlist[Math.floor(Math.random()*shortlist.length)];
}