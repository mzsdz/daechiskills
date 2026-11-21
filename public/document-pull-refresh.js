import {installPullToRefresh} from './pull-refresh-core.js';

document.documentElement.classList.add('pull-refresh-document');
installPullToRefresh({reloadOnRefresh:true,refresh:()=>location.reload()});
