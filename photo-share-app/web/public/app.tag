<app>
<ul if={loaded} class="rslides">
  <li each={url in urls}><img src={url} alt=""></li>
</ul>
<div class="slideshow-container">
  <div each={images} class="mySlides fade">
    <img src={full_url} style="width:100%">
    <div class="text">{text}</div>
  </div>

  <div class="mySlides fade">
    <img src={full_url}  style="width:100%">
    <div class="text">{text}</div>
  </div>

  <div class="mySlides fade">
    <img src={full_url}  style="width:100%">
    <div class="text">{text}</div>
  </div>

  <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
  <a class="next" onclick="plusSlides(1)">&#10095;</a>
</div>
<script>
	a = this
	var self = this
	this.images = []
	this.loaded = false

	this.on("mount", function(){
		// refresh = function(){
		// 	self.loaded = false; 	self.update()
		// 	firebase.database().ref('/posts/').once('value').then(function(snapshot) {
		// 		self.loaded= true
	 //  		v = snapshot.val();
		// 	  console.log(v);
		// 	  var vals = _.values(v);
		// 	  self.urls = _.pluck(vals, "full_url")
		// 	  self.urls.reverse()
		// 	  console.log(self.urls);
		// 	  self.update()
		// 	  $(".rslides").responsiveSlides();
		// 	});		
		// }
		// setInterval(refresh, 15000)	
		slideIndex = 0;

		var thisDeviceListRef =  firebase.database().ref('/posts/')
			thisDeviceListRef.on("child_added", function(snapshot) {
				self.loaded = false
				self.update()
				value = snapshot.val()
				if (value){
					console.log(value);
					self.images.unshift(value)
					self.loaded = true
				  // var vals = _.values(v);
				  // self.urls = _.pluck(vals, "full_url")
				  // self.urls.reverse()
				  // console.log(self.urls);
				  self.update()
				  
					showSlides();
					
				}
				
			});
		// refresh()	
	})



function showSlides() {
    var i;
    var slides = document.getElementsByClassName("mySlides");
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none"; 
    }
    slideIndex++;
    if (slideIndex> slides.length) {slideIndex = 1} 
    slides[slideIndex-1].style.display = "block"; 
    setTimeout(showSlides, 2000); // Change image every 2 seconds
}


</script>
<style>
	* {box-sizing:border-box}

/* Slideshow container */
.slideshow-container {
  max-width: 1000px;
  position: relative;
  margin: auto;
}

.mySlides {
    display: none;
}

/* Next & previous buttons */
.prev, .next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  margin-top: -22px;
  padding: 16px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
}

/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.8);
}

/* Caption text */
.text {
  color: #f2f2f2;
  font-size: 15px;
  padding: 8px 12px;
  position: absolute;
  bottom: 8px;
  width: 100%;
  text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* The dots/bullets/indicators */
.dot {
  cursor:pointer;
  height: 13px;
  width: 13px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.active, .dot:hover {
  background-color: #717171;
}

/* Fading animation */
.fade {
  -webkit-animation-name: fade;
  -webkit-animation-duration: 1.5s;
  animation-name: fade;
  animation-duration: 1.5s;
}

@-webkit-keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

@keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}
</style>
</app>
