$(function(){

	rotateTimeout = setInterval (rotatePic, displayTime);



});

var pics = $("#pic-span img"),
	totalPics = pics.length,
	activeIndex = 0,
	displayTime = 5000, //in ms
	rotateTimeout = null;




var updatePicMeta = function(){
	pics = $("#pic-span img");
	totalPics = pics.length;
	activeIndex = activeIndex >= totalPics ? totalPics - 1 : activeIndex;
}

var rotatePic = function(){
	//make sure we're all good in case someone wants to dynamically add a picture
	updatePicMeta();


	var nextPicIndex = (activeIndex+1) >= totalPics ? 0 : activeIndex + 1;

	//set the active pic to be behind the next pic
	$(pics[activeIndex]).css("z-index", 50);

	//set the next pic to be infront of the current pic
	$(pics[nextPicIndex]).css("z-index", 51);

	//fade in the next pic
	$(pics[nextPicIndex]).fadeIn({
		duration: 400,
		easing: 'swing',
		complete: function(){
			//hide the last photo and set the current photo index
			$(pics[activeIndex]).hide();
			activeIndex=nextPicIndex;
		}
	});

}