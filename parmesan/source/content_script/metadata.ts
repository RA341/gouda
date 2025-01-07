// get metadata for the release

import {Media} from "../gen/media_requests/v1/media_requests_pb";

function getMetadata() {
	const author = getAuthorText()!
	const bookName = getTitleText()!
	const link = getDownloadLink()!
	const book_url = getBookUrlId()!
	const cat = getCategory()
	const {seriesName, seriesNumber} = getSeriesNameAndNumber()

	console.log('Metadata retrieved:')
	console.log(`Category: ${cat} - Author: ${author} - Book: ${bookName} - Series name: ${seriesName} - Series number: ${seriesNumber}`);

	const media = <Media>{
		author: author,
		book: bookName,
		fileLink: link,
		mamBookId: book_url,
		category: cat,
	}

	if (seriesName != null && seriesNumber != null) {
		media.series = seriesName
		media.seriesNumber = seriesNumber
	}
	return media;
}

function getAuthorText() {
	const authorElement = document.querySelector('.torDetRight.torAuthors a');
	if (authorElement) {
		return authorElement.textContent?.trim();
	}
	console.log('Author element not found');
	return null;
}

function getTitleText() {
	const titleElement = document.querySelector('.torDetRight .TorrentTitle');
	if (titleElement) {
		return titleElement.textContent?.trim();
	}
	console.log('Title element not found');
	return null;
}

function getDownloadLink(): string | null {
	const downloadElement = document.querySelector<HTMLAnchorElement>('#tddl');
	if (downloadElement) {
		return downloadElement.href;
	}
	console.log('Download link not found');
	return null;
}

function getBookUrlId(): bigint | null {
	const id = window.location.href.split('/').pop()
	if (!id) {
		console.error('No book id found');
		return null
	}
	return BigInt(id);
}

function getCategory(): string {
	const dropdown = document.getElementById('gouda_cat') as HTMLSelectElement;
	const value = dropdown?.value;
	return value ? value.toString() : '';
}

function getSeriesNameAndNumber(): { seriesName: string | null; seriesNumber: number | null } {
	const seriesDiv = document.querySelector<HTMLDivElement>('#Series');
	if (!seriesDiv) {
		return {seriesName: null, seriesNumber: null};
	}

	const firstLink = seriesDiv.querySelector<HTMLAnchorElement>('a');
	const seriesName = firstLink?.textContent?.trim() || null;
	if (!seriesName) {
		console.debug('SeriesName not found');
		return {seriesName: null, seriesNumber: null};
	}

	// Extract number after the first #
	const text = seriesDiv.textContent || '';
	const numberMatch = text.match(/#(\d+)/);
	const seriesNumber = numberMatch ? numberMatch[1] : null;

	if (!seriesNumber) {
		console.debug(`SeriesName:${seriesName}, but series number not found`);
		return {seriesName: seriesName, seriesNumber: null};
	}

	return {seriesName, seriesNumber: parseInt(seriesNumber, 10)};
}

export {
	getMetadata
}
