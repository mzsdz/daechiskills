import {createSharePageHandler} from '../server/share-page-handler.mjs';
import {shareShell} from '../server/share-shell.mjs';
export const GET=createSharePageHandler({shell:shareShell});
