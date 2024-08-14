import countriesData from "$lib/countriesData";
import { staleQueue } from "$lib/staleQueue";

export default function() {
    // TODO IMPLEMENT STALE QUEUE - const shortlist = countriesData.filter((country) => !staleQueue.includes(country));
    const shortlist = countriesData;
    return shortlist[Math.floor(Math.random()*shortlist.length)];
}