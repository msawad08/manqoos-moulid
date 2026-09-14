const app = document.querySelector('#app');
const state = { screen: 'home', language: 'Kannada', selectedReciter: 0 };

const chapters = ['Hadees & Baith', 'Hadees & Baith', 'Hadees & Baith', 'Hadees & Baith', 'Hadees & Baith', 'Dua'];
const verses = [
  'ಸರ್ವಾನುಗಳೂ ಪ್ರವಾದಿ ಸಲ್ಲಲ್ಲಾಹು ಅಲೈಹಿವಸಲ್ಲಮರ ಮೇಲೆ ಪ್ರೀತಿಯಿಂದ ಮೌಲಿದ್ ಆಚರಿಸುವುದು ಉತ್ತಮವಾದ ಕಾರ್ಯವಾಗಿದೆ.',
  'ಈ ಪ್ರಾರ್ಥನೆಗೆ ಅಲ್ಲಾಹನು ಮುಹಮ್ಮದ್ ಎಂದು ನಾಮಕರಣ ಮಾಡಿದನು.',
  'ಅಲ್ಲಾಹನು ತನ್ನ ವಿಧಿಯಂತೆ ಮಲಕುಗಳಿಗೆ ಪೂರ್ವ ಪ್ರವಾದಿಗಳಿಗೆ ದರ್ಶನ ಮಾಡಿಸಿದಂತೆ ಈ ಪ್ರವಾದಿ ಸಲ್ಲಲ್ಲಾಹು ಅಲೈಹಿವಸಲ್ಲಮರ ಪ್ರಕಾರವನ್ನು ನಮಗೆ ಕಲಿಸಿದನು.'
];

function header(title, subtitle = '', back = true) {
  return `<header class="topbar"><button class="back" data-action="home" aria-label="Back">‹</button><h1>${title}${subtitle ? `<span>${subtitle}</span>` : ''}</h1><div class="header-arch"></div></header>`;
}
function bottom(active = 'home') {
  return `<nav class="bottom-nav"><button class="${active === 'home' ? 'active' : ''}" data-action="home"><span class="icon">⌂</span>HOME</button><button class="${active === 'translation' ? 'active' : ''}" data-action="reader"><span class="icon">▣</span>TRANSLATION</button><button class="${active === 'settings' ? 'active' : ''}" data-action="settings"><span class="icon">⚙</span>SETTINGS</button></nav>`;
}
function home() {
  const items = [['▤','Mawlid','chapters'],['☷','Q&A','about'],['ⓘ','About Mawlid','about-mawlid'],['♟','Reciter','reciter'],['⚙','Settings','settings'],['▧','About App','about-app'],['✦','About Us','about'],['•','Share','share']];
  return `<header class="topbar home-header"><div class="logo-mark">ISLAMIC WAY<small>The Solution for Humanity</small></div><div class="date"><b>12 SEPTEMBER 2026</b>00:46</div><div class="header-arch"></div></header><section class="home-grid">${items.map(([icon,label,action]) => `<button class="menu-button" data-action="${action}"><span class="tile"><span>${icon}</span></span><label>${label}</label></button>`).join('')}</section>${bottom('home')}`;
}
function chaptersPage() { return `${header('Chapters','ಅಧ್ಯಾಯ')}<section class="section-body"><div class="frame">${chapters.map((c,i)=>`<button class="chapter" data-action="reader">0${i+1} ${c}</button>`).join('')}</div></section>${bottom('home')}`; }
function aboutPage(title, text) { return `${header(title, title === 'About Mawlid' ? 'ಮೌಲಿದ್ ಬಗ್ಗೆ' : 'ಅಪ್ಲಿಕೇಶನ್ ಬಗ್ಗೆ')}<article class="content-panel"><p class="about-copy kannada">${text}</p></article>${bottom('home')}`; }
function reciterPage() { return `${header('Reciter','ಪಠಣಗಾರರು')}<section class="section-body"><div class="frame">${['Sayyid Thaha Tangal Pookkottur / Hafiz Nizamuddeen Mahmoodi','Arif Sa\'adi Katipalla'].map((name,i)=>`<button class="reciter-card ${i ? 'muted':''}" data-reciter="${i}"><span class="play-circle">▶</span><span>${name}</span><img src="thahatangal pic.png" alt="Reciter"></button>`).join('')}</div></section>${bottom('home')}`; }
function settingsPage() { return `${header('Settings','ಸೆಟ್ಟಿಂಗ್ಸ್')}<article class="content-panel"><div class="settings-row"><span>Translation<br>Language</span><div class="segmented"><button class="${state.language === 'Kannada' ? 'active':''}" data-lang="Kannada">Kannada</button><button class="${state.language === 'English' ? 'active':''}" data-lang="English">English</button></div></div></article>${bottom('settings')}`; }
function readerPage() { return `<div class="reader">${header('Mawlid Translation','',false)}<div class="arabic">بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ</div>${verses.map((v,i)=>`<div class="verse ${i === 0 ? 'active':''}"><div class="arabic">سُبْحَانَ الَّذِي أَطْلَعَ فِي شَهْرِ رَبِيعِ الأَوَّلِ</div>${state.language === 'Kannada' ? v : 'The one who brought forth the first spring month and showed its light before the creation of the world.'} <sup>${i+1}</sup></div>`).join('')}<div class="player"><span class="play-circle">▶</span><span class="track">Sayyid Thaha Tangal Pookkottur / Hafiz...<div class="progress"><i></i></div></span><span>⌄</span></div><div class="reader-actions"><button data-action="toast">▤<br>EXPLANATION</button><button data-action="toast">▣<br>COPY</button><button data-action="share">●<br>SHARE</button></div></div>${bottom('translation')}`; }
function render() { const screens = { home, chapters: chaptersPage, reciter: reciterPage, settings: settingsPage, reader: readerPage, 'about-mawlid': () => aboutPage('About Mawlid','ಶೈಖ್ ರಯ್ಯುಸುದ್ದೀನ್ ಮಹಮ್ಮದ್ ಮೌಲಿದ್ ಕತ್ತರ್ ಪ್ರವಾದಿ ಸಲ್ಲಲ್ಲಾಹು ಅಲೈಹಿವಸಲ್ಲಮರ ಮೇಲೆ ಪ್ರೀತಿಯಿಂದ ಮೌಲಿದ್ ಕೂಡಿ ಒಂದು ಸರಳ ಸುಂದರವಾದ ಶೈಲಿಯಲ್ಲಿ ಓದಲು ಸಿದ್ಧಪಡಿಸಲಾಗಿದೆ.'), 'about-app': () => aboutPage('About App','ಕನ್ನಡಕ್ಕೆ ಅನುವಾದ - ನೌಫಲ್ ಮರ್ಝೂಕಿ ಮಲಾರ್<br><br>ಇಂಗ್ಲಿಷ್ ಅನುವಾದ - ಶಫೀಕ್ ಹುದವಿ') }; app.innerHTML = (screens[state.screen] || home)(); bind(); }
function bind() { document.querySelectorAll('[data-action]').forEach(el => el.addEventListener('click', () => { const action = el.dataset.action; if (action === 'share') return showToast('Share link copied'); if (action === 'toast') return showToast('Copied to clipboard'); state.screen = action === 'home' ? 'home' : action; render(); })); document.querySelectorAll('[data-lang]').forEach(el => el.addEventListener('click', () => { state.language = el.dataset.lang; render(); })); document.querySelectorAll('[data-reciter]').forEach(el => el.addEventListener('click', () => { state.selectedReciter = Number(el.dataset.reciter); showToast('Reciter selected'); })); }
function showToast(message) { const toast = document.createElement('div'); toast.className = 'toast'; toast.textContent = message; document.body.append(toast); setTimeout(() => toast.remove(), 1800); }
render();
