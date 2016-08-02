$(document).ready(function(){
	$("#datepicker-1, #datepicker-2, #datepicker-3, #datepicker-4").datepicker({
		dayNamesMin: [ "Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Нд" ],
		monthNames: [ "Січень", "Лютий", "Березень", "Квітень",
                   "Травень", "Червень", "Липень", "Серпень", "Вересень",
                   "Жовтень", "Листопад", "Грудень" ],
    prevText: "Попередній",
    nextText: "Наступний"
	});
})
