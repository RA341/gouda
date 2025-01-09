export type CategoryResponse = { cat: string[]; err: string; };

export type MediaResponse = { error: string; };

export type BookMetadata = {
	bookName: string,
	author: string,
	series: string,
	seriesNumber: number,
	category: string,
	fileLink: string,
	mamBookId: string,
}

export type MessageRequest =
	| { type: 'NEW_MEDIA'; media: BookMetadata }
	| { type: 'GET_CATEGORIES' }
	| { type: 'SETUP_COMPLETE' }
