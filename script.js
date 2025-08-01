<<<<<<< HEAD
function toggleMode() {
    const html = document.documentElement
    html.classList.toggle("light")
  
    const img = document.querySelector("#profile img")
  
    if (html.classList.contains("light")) {
      img.setAttribute("src", "./assets/avatar-ligth.png")
    } else {
      img.setAttribute("src", "./assets/avatar.png")
    }
  }
  
  /*pegar a tag img*/
  
  //se tiver light mode,adicionar a imag light
  //se tiver sem light mode, manter a imagem nomrmal
=======
function toggleMode() {
    const html = document.documentElement
    html.classList.toggle("light")
  
    const img = document.querySelector("#profile img")
  
    if (html.classList.contains("light")) {
      img.setAttribute("src", "./assets/avatar-ligth.png")
    } else {
      img.setAttribute("src", "./assets/avatar.png")
    }
  }
  
  /*pegar a tag img*/
  
  //se tiver light mode,adicionar a imag light
  //se tiver sem light mode, manter a imagem nomrmal
>>>>>>> 9e78fc60d30bbcc998cb03c7f5cb7ef2beaab78a
  