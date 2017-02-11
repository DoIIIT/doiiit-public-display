<app>
<ul if={loaded} class="rslides">
  <li each={url in urls}><img src={url} alt=""></li>
</ul>
<script>
	a = this
	var self = this
	this.urls = []
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

		var thisDeviceListRef =  firebase.database().ref('/posts/')
			thisDeviceListRef.on("child_added", function(snapshot) {
				self.loaded = false
				self.update()
				value = snapshot.val()
				if (value){
					console.log(value.full_url);
					self.urls.unshift(value.full_url)
					self.loaded = true
				  // var vals = _.values(v);
				  // self.urls = _.pluck(vals, "full_url")
				  // self.urls.reverse()
				  // console.log(self.urls);
				  self.update()
				  $(".rslides").responsiveSlides();
					
				}
				
			});
		// refresh()	
	})




</script>
</app>
