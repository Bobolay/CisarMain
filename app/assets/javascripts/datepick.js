$(document).on("ready page:load", function(){
	$(".datepicker").datepicker({
        firstDay: 1,
		dayNamesMin: [ "Нд", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб" ],
		monthNames: [ "Січень", "Лютий", "Березень", "Квітень",
                   "Травень", "Червень", "Липень", "Серпень", "Вересень",
                   "Жовтень", "Листопад", "Грудень" ],
    prevText: "Попередній",
    nextText: "Наступний",
    dateFormat: "dd.mm.yy"    
	});
})
