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

  $('body').on('click', '#task_submit', function(){
    form = $(this).parents('form');
    $.post(
          form.attr('action'),
          form.serialize(),
          function(data, textStatus, jqXHR){
            renderTaskList();
          }
        );
  });

  $('body').on('click', '.task-list-item', function(event){
    renderTaskForm($(this).data('id'));
  });
});

function renderTaskForm(taskId){
  if (taskId === undefined) taskId = false;

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
