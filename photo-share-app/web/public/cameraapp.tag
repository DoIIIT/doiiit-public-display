<cameraapp>
<video id="video" width="640" height="480" autoplay></video>
<button onclick={snap} id="snap">Snap Photo</button>
<canvas id="canvas" width="640" height="480"></canvas>

<script>
	a = this
	var self = this
	this.urls = []
	this.loaded = false

	snap(){
		// Elements for taking the snapshot
		var canvas = document.getElementById('canvas');
		var context = canvas.getContext('2d');
		var video = document.getElementById('video');

		// Trigger photo take
		document.getElementById("snap").addEventListener("click", function() {
			context.drawImage(video, 0, 0, 640, 480);
			var canvasData = canvas.toDataURL("image/png");
			var filename = (new Date()).toString()
			canvas.toBlob(function(blob){
			  var image = new Image();
			  image.src = blob;
			  self.uploadNewPic(blob, filename, "")
			}); 
			

		});
	}
	uploadNewPic(pic, fileName, text) {
	    // Get a reference to where the post will be created.
	    const newPostKey = firebase.database().ref('/posts/').push().key;

	    // Start the pic file upload to Firebase Storage.
	    const picRef = firebase.storage().ref(`doiiit-photobooth/full/${newPostKey}/${fileName}`);
	    const metadata = {
	      contentType: pic.type
	    };
	    var picUploadTask = picRef.put(pic, metadata).then(snapshot => {
	      console.log('New pic uploaded. Size:', snapshot.totalBytes, 'bytes.');
	      var url = snapshot.metadata.downloadURLs[0];
	      console.log('File available at', url);

	     
	     var update = {
	          full_url: url,
	          thumb_url: url,
	          text: text,
	          timestamp: firebase.database.ServerValue.TIMESTAMP,
	          full_storage_uri: picRef.toString(),
	          thumb_storage_uri: picRef.toString(),
	          author: {
	            uid: "doiiit-photobooth",
	            full_name: "doiiit-photobooth",
	            profile_picture: ""
	          }
	        };
	        var logList =  firebase.database().ref('/posts/')
	        var newLogRef = logList.push()
	        newLogRef.set(update).then(function(){
	          console.log('Saved log to firebase');
	        })

	    }).catch(error => {
	      console.error('Error while uploading new pic', error);
	    });


	}

	this.on("mount", function(){
		// Grab elements, create settings, etc.
		var video = document.getElementById('video');

		// Get access to the camera!
		if(navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
		    // Not adding `{ audio: true }` since we only want video now
		    navigator.mediaDevices.getUserMedia({ video: true }).then(function(stream) {
		        video.src = window.URL.createObjectURL(stream);
		        video.play();
		    });
		}


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
</cameraapp>
