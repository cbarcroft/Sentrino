$(document).ready(function(){
	$.each($('.device-list-item'), function(){
		device_id = $(this).attr('id');
		ajaxSensorReadings(device_id);
		ajaxTaskList(device_id);
	});

	$('body').on('click', '.icon-refresh', function(event){
		device_id = $(this).parents('.device-list-item').attr('id');
		ajaxSensorReadings(device_id);
		ajaxTaskList(device_id);
		event.preventDefault();
	});
});

function ajaxSensorReadings(device_id){
	$.get('devices/' + device_id + '/sensor_status', function(data){
			$('#' + device_id).find('.device-readings').html(data);
		});
}

function ajaxTaskList(device_id){
	$.get('devices/' + device_id + '/task_status', function(data){
			$('#' + device_id).find('.device-tasks').html(data);
		});
}