$(document).ready(function() {
  $('#goal_due_date').datepicker(
    {  dateFormat: "MM dd, yy",
       monthNames: ["January",
                    "February",
                    "March",
                    "April",
                    "May",
                    "June",
                    "July",
                    "August",
                    "September",
                    "October",
                    "November",
                    "December" ]
    });
});
