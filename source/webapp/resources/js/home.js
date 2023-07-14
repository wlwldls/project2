var slideIndex = 0;
showSlides();
function showSlides() {
    var i;
    var slides = document.getElementsByClassName("mySlides");
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";  
    }
    slideIndex++;
    if (slideIndex > slides.length) {
        slideIndex = 1
    }    
    slides[slideIndex-1].style.display = "block";  
    setTimeout(showSlides, 3000);
}
function hrefGo(){
    var hrefLink = document.getElementById("hrefSelect").value
    console.log(hrefLink)
    window.open(hrefLink)
}
$("#navhover1").hover(
    function(){
        $("#navhover1").css({"background-color":"#216eae"})
        $("#navhover1>div").css({"color":"#ffffff"})
    },
    function(){
        $("#navhover1").css({"background-color":"transparent"})
        $("#navhover1>div").css({"color":"#666"})
    }
)
$("#navhover2").hover(
    function(){
        $("#navhover2").css({"background-color":"#216eae"})
        $("#navhover2>div").css({"color":"#ffffff"})
    },
    function(){
        $("#navhover2").css({"background-color":"transparent"})
        $("#navhover2>div").css({"color":"#666"})
    }
)
$("#navhover3").hover(
    function(){
        $("#navhover3").css({"background-color":"#216eae"})
        $("#navhover3>div").css({"color":"#ffffff"})
    },
    function(){
        $("#navhover3").css({"background-color":"transparent"})
        $("#navhover3>div").css({"color":"#666"})
    }
)
$("#navhover4").hover(
    function(){
        $("#navhover4").css({"background-color":"#216eae"})
        $("#navhover4>div").css({"color":"#ffffff"})
    },
    function(){
        $("#navhover4").css({"background-color":"transparent"})
        $("#navhover4>div").css({"color":"#666"})
    }
)
$("#navhover5").hover(
    function(){
        $("#navhover5").css({"background-color":"#216eae"})
        $("#navhover5>div").css({"color":"#ffffff"})
    },
    function(){
        $("#navhover5").css({"background-color":"transparent"})
        $("#navhover5>div").css({"color":"#666"})
    }
)
$("#navhover6").hover(
    function(){
        $("#navhover6").css({"background-color":"#216eae"})
        $("#navhover6>div").css({"color":"#ffffff"})
    },
    function(){
        $("#navhover6").css({"background-color":"transparent"})
        $("#navhover6>div").css({"color":"#666"})
    }
)
$("#xbox").hover(
    function(){
        document.getElementById("xbox").className = "xbox1";
    },
    function(){
        document.getElementById("xbox").className = "xbox";
    }
)
function popupOpen(){
    if ($('#popup').css('display') == 'none') {
        $('#popup').css('display', 'block');
    }
}
function popupClose(){
    if ($('#popup').css('display') == 'block') {
        $('#popup').css('display', 'none');
    }
}
const wrap = document.querySelector("#popup");
const header = document.querySelector("#header");
let lastX = 0;
let lastY = 0; 
let startX = 0; 
let startY = 0; 

// 1.
header.addEventListener('mousedown', function(e){
  e.preventDefault(); 
  startX = e.clientX; 
  startY = e.clientY; 
	
  // 2.  
  header.classList.add('active');
  
  // 3.
  document.addEventListener('mouseup', onRemoveEvent); 
  
  // 4.
  document.addEventListener('mousemove', onMove); 
});

function onRemoveEvent() { 
  header.classList.remove('active');
  document.removeEventListener('mouseup', onRemoveEvent); 
  document.removeEventListener('mousemove', onMove); 
} 

function onMove(e) { 
  e.preventDefault(); 
  lastX = startX - e.clientX; 
  lastY = startY - e.clientY; 

  startX = e.clientX; 
  startY = e.clientY; 

  wrap.style.top = `${wrap.offsetTop - lastY}px`;
  wrap.style.left = `${wrap.offsetLeft - lastX}px`;
}