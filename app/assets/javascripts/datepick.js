$(document).ready(function(){
	$(".datepicker").datepicker({
		dayNamesMin: [ "Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Нд" ],
		monthNames: [ "Січень", "Лютий", "Березень", "Квітень",
                   "Травень", "Червень", "Липень", "Серпень", "Вересень",
                   "Жовтень", "Листопад", "Грудень" ],
    prevText: "Попередній",
    nextText: "Наступний",
    dateFormat: "dd.mm.yy"    
	});
})
