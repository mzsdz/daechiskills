import {createPublicContentHandler} from '../server/public-content-handler.mjs';
import {publicBackendConfig} from '../server/public-backend-config.mjs';
export const GET=createPublicContentHandler(publicBackendConfig);
