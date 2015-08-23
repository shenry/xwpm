var id = "<%= @component.id %>",
		element = $("tr#component-" + id),
		tds = element.find("td"),
		l = tds.length;
console.log("id = " + id);
tds.fadeOut(300, function() { 
	if (! --l){
		element.remove();
	}
});