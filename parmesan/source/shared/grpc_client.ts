import {createConnectTransport} from "@connectrpc/connect-web";
import {createClient, Interceptor, Transport} from "@connectrpc/connect";
import {CategoryService} from "../gen/category/v1/category_pb";
import {MediaRequestService} from "../gen/media_requests/v1/media_requests_pb";
import {AuthService} from "../gen/auth/v1/auth_pb";


function createGRPCTransport(baseUrl: string, apikey: string) {
	const auth: Interceptor = (next) => async (req) => {
		req.header.append('Authorization', `${apikey}`);
		console.log(`sending message to ${req.url}, ${req.header}`);
		return await next(req);
	};

	return createConnectTransport({
		baseUrl: baseUrl,
		interceptors: [auth]
	});
}

function createCategoryClient(transport: Transport) {
	return createClient(CategoryService, transport);
}


function createMediaRequestClient(transport: Transport) {
	return createClient(MediaRequestService, transport);
}

function createAuthClient(transport: Transport) {
	return createClient(AuthService, transport);
}

export {
	createGRPCTransport,
	createCategoryClient,
	createMediaRequestClient,
	createAuthClient,
}
