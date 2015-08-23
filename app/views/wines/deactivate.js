var id = "<%= @wine.id %>";
var element = $("tr#wine-" + id);
var tds = element.find("td");
var l		= tds.length;
console.log("wine id is " + id);
tds.fadeOut(300, function(){
	if (! --l) {
		element.remove();
	}
});
		
