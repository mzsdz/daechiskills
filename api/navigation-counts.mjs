import {createNavigationCountsHandler} from '../server/navigation-counts-handler.mjs';
import {publicBackendConfig} from '../server/public-backend-config.mjs';
export const GET=createNavigationCountsHandler(publicBackendConfig);
