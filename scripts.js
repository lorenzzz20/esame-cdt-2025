// ===================================================
// LIGHTBOX per facsimile
// ===================================================
function openLightbox(src) {
  const overlay = document.getElementById('lightbox-overlay');
  const img = document.getElementById('lightbox-image');
  img.src = src;
  overlay.style.display = 'flex';
}

function closeLightbox() {
  const overlay = document.getElementById('lightbox-overlay');
  overlay.style.display = 'none';
}

// ===================================================
// BUTTONS per evidenziare elementi
// ===================================================
document.addEventListener("DOMContentLoaded", function() {
  const buttons = document.querySelectorAll('#buttons button');

  buttons.forEach(button => {
    button.addEventListener('click', function() {
      const tagClass = this.getAttribute('data-class');
      const highlightClass = this.getAttribute('data-highlight-class');
      const termType = this.getAttribute('data-type');

      // Se è reset-filters
      if (this.classList.contains('btn-reset')) {
        resetHighlights();
        return;
      }

      // Evidenzia solo tag specifici
      highlightElements(tagClass, highlightClass, termType);
    });
  });
});

// Evidenzia elementi specifici
function highlightElements(tagClass, highlightClass, termType = null) {
  const elements = document.querySelectorAll(`.${tagClass}`);
  elements.forEach(el => {
    if (termType) {
      if (el.getAttribute('data-type') === termType) {
        el.classList.add(highlightClass);
      }
    } else {
      el.classList.add(highlightClass);
    }
  });
}

// Reset dei highlight
function resetHighlights() {
  const allElements = document.querySelectorAll('[class*="highlight-"]');
  allElements.forEach(el => {
    Array.from(el.classList).forEach(cls => {
      if (cls.startsWith('highlight-')) {
        el.classList.remove(cls);
      }
    });
  });
}

// ===================================================
// FUNZIONE PER EVIDENZIARE TUTTI GLI ELEMENTI
// ===================================================
function highlightAllElements() {
  const elementsToHighlight = [
    { tagClass: 'persName', highlightClass: 'highlight-person' },
    { tagClass: 'placeName', highlightClass: 'highlight-place' },
    { tagClass: 'orgName', highlightClass: 'highlight-org' },
    { tagClass: 'title', highlightClass: 'highlight-title' },
    { tagClass: 'addName', highlightClass: 'highlight-addName' },
    { tagClass: 'roleName', highlightClass: 'highlight-roleName' },
    { tagClass: 'name', highlightClass: 'highlight-name' },
    { tagClass: 'foreign', highlightClass: 'highlight-foreign' },
    { tagClass: 'quote', highlightClass: 'highlight-quote' },
    { tagClass: 'hi', highlightClass: 'highlight-hi' },
    { tagClass: 'note', highlightClass: 'highlight-note' },
    { tagClass: 'date', highlightClass: 'highlight-date' },
    // Termini
    { tagClass: 'term', highlightClass: 'highlight-theme', termType: 'theme' },
    { tagClass: 'term', highlightClass: 'highlight-legal', termType: 'legal' },
    { tagClass: 'term', highlightClass: 'highlight-moral', termType: 'moral' },
    { tagClass: 'term', highlightClass: 'highlight-economic', termType: 'economic' },
    { tagClass: 'term', highlightClass: 'highlight-nonStandard', termType: 'nonStandard' },
    { tagClass: 'term', highlightClass: 'highlight-textual', termType: 'textual' },
    { tagClass: 'term', highlightClass: 'highlight-social', termType: 'social' },
    { tagClass: 'term', highlightClass: 'highlight-infrastructure', termType: 'infrastructure' },
    { tagClass: 'term', highlightClass: 'highlight-literaryMovement', termType: 'literaryMovement' }
  ];

  elementsToHighlight.forEach(item => {
    highlightElements(item.tagClass, item.highlightClass, item.termType || null);
  });
}

// Aggiunge listener al bottone "highlight-all"
document.getElementById('highlight-all')?.addEventListener('click', highlightAllElements);

// ===================================================
// TOGGLE SCELTE (orig-sic -> corr-reg) e TERM
// ===================================================
let isCorrected = false;

document.addEventListener("DOMContentLoaded", function() {
  const switchButton = document.getElementById('switch-choice');

  if (!switchButton) return;

  switchButton.addEventListener('click', function() {
    // ---- CHOICE ----
    const choices = document.querySelectorAll('.choice');
    choices.forEach(choice => {
      const orig = choice.querySelector('.orig-sic');
      const corr = choice.querySelector('.corr-reg');
      if (orig && corr) {
        if (!isCorrected) {
          orig.style.display = 'none';
          corr.style.display = 'inline';
          corr.classList.add('corrected-highlight');
        } else {
          orig.style.display = 'inline';
          corr.style.display = 'none';
          corr.classList.remove('corrected-highlight');
        }
      }
    });

    // ---- TERM ----
    const terms = document.querySelectorAll('.term');
    terms.forEach(term => {
      const orig = term.querySelector('.orig-sic');
      const corr = term.querySelector('.corr-reg');
      if (orig && corr) {
        if (!isCorrected) {
          orig.style.display = 'none';
          corr.style.display = 'inline';
          corr.classList.add('corrected-highlight');
        } else {
          orig.style.display = 'inline';
          corr.style.display = 'none';
          corr.classList.remove('corrected-highlight');
        }
      }
    });
    
    // ---- TOGGLE BUTTON ----
    isCorrected = !isCorrected;
    switchButton.textContent = isCorrected 
      ? 'Mostra versione originale' 
      : 'Mostra versione corretta';
  });
});
