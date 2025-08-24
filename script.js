document.addEventListener('DOMContentLoaded', () => {

  // ==============================================
  // ========= LÓGICA DO CURSOR INTERATIVO ========
  // ==============================================
  const cursorDot = document.querySelector(".cursor-dot");
  const cursorOutline = document.querySelector(".cursor-outline");

  window.addEventListener("mousemove", function (e) {
    const posX = e.clientX;
    const posY = e.clientY;

    cursorDot.style.left = `${posX}px`;
    cursorDot.style.top = `${posY}px`;

    cursorOutline.animate({
        left: `${posX}px`,
        top: `${posY}px`
    }, { duration: 500, fill: "forwards" });
  });
  
  const interactiveElements = document.querySelectorAll("a, .card, .badges img, button");

  interactiveElements.forEach((element) => {
    element.addEventListener("mouseenter", () => {
      cursorOutline.classList.add("cursor-interact");
    });
    element.addEventListener("mouseleave", () => {
      cursorOutline.classList.remove("cursor-interact");
    });
  });

  // ==============================================
  // ======== LÓGICA DO "SOBRE MIM" EXPANSÍVEL ====
  // ==============================================
  const sobreSection = document.querySelector('#sobre');
  const sobreHeader = document.querySelector('.sobre-header');

  if (sobreHeader && sobreSection) {
    sobreHeader.addEventListener('click', () => {
      sobreSection.classList.toggle('open');
    });

    // Opcional: Adiciona acessibilidade via teclado
    sobreHeader.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        sobreSection.classList.toggle('open');
      }
    });
  }

  // ==============================================
  // =========== LÓGICA DA ROLAGEM SUAVE ==========
  // ==============================================
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener("click", function(e) {
      e.preventDefault();
      const targetElement = document.querySelector(this.getAttribute("href"));
      if (targetElement) {
        targetElement.scrollIntoView({ behavior: "smooth" });
      }
    });
  });

  // ==============================================
  // ====== LÓGICA DA ANIMAÇÃO DE ENTRADA =========
  // ==============================================
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("visible");
        }
      });
    },
    {
      threshold: 0.1,
    }
  );

  const elementsToAnimate = document.querySelectorAll(
    ".card, #sobre p, #habilidades .badges, #contato .social-links"
  );

  elementsToAnimate.forEach((element) => {
    observer.observe(element);
  });

});
// ==============================================
// ===== LÓGICA DE CLIQUE NOS PROJETOS GITHUB ====
// ==============================================
document.querySelectorAll('#github .card').forEach(card => {
  card.addEventListener('click', () => {
    const url = card.getAttribute('data-url');
    if (url) {
      window.open(url, '_blank');
    }
  });
});

// Adicionar os cards do GitHub à lista de elementos interativos
const githubCards = document.querySelectorAll('#github .card');
githubCards.forEach(card => {
  card.addEventListener('mouseenter', () => {
    cursorOutline.classList.add("cursor-interact");
  });
  card.addEventListener('mouseleave', () => {
    cursorOutline.classList.remove("cursor-interact");
  });
});