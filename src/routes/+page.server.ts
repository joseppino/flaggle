import type { PageServerLoad } from './$types';

import selectRandomCountry from "$lib/selectRandomCountry";

export const load: PageServerLoad = async ({ params }) => {
  let country: any = selectRandomCountry();

	return {
		country: country
	};
};