$(document).ready(function(){
  $.get($('#task_form').data('new-url'), function(data){
    $('#task_form').html(data);
  });
  $.get($('#task_index').data('new-url'), function(data){
    $('#task_index').html(data);
  });

  $('body').on('click', '.remove_fields', function(event){
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').hide();
    event.preventDefault();
  });

  $('body').on('click', '.add_fields', function(event){
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();
  });

  $('body').on('click', '.task-list-item', function(event){
    renderTaskForm($(this).data('id'));
  });

  $('#new_task').submit(function(){
    $.post(
      $(this).attr('action'),
      $(this).serialize(),
      function(data, textStatus, jqXHR){
        renderTaskList();
      }
    );
    return false;
  });
});

function renderTaskForm(taskId = false){
  if (taskId){
    url = $('#task_form').data('edit-url').replace('?', taskId);
  } else {
    url = $('#task_form').data('new-url');
  }

  $.get(url, function(data){
    $('#task_form').html(data);
  });
}

function renderTaskList(){
  $.get($('#task_index').data('new-url'), function(data){
    $('#task_index').html(data);
  });
}
