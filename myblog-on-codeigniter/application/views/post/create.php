<?php

$title = array(
    'name'	=> 'title',
    'id'	=> 'title',
    'value' => set_value('title'),
    'maxlength'	=> 255,
    'size'	=> 30,
);

$body = array(
	'name'	=> 'body',
	'id'	=> 'body',
	'value'	=> set_value('body'),
	'rows'	=> 20,
	'cols'	=> 42,
);

?>
<?php echo form_open($this->uri->uri_string()); ?>
<table>

	<tr>
		<td><?php echo form_label('Title', $title['id']); ?></td>
		<td><?php echo form_input($title); ?></td>
		<td style="color: red;"><?php echo form_error($title['name']); ?><?php echo isset($errors[$title['name']])?$errors[$title['name']]:''; ?></td>
	</tr>

	<tr>
		<td><?php echo form_label('Body', $body['id']); ?></td>
		<td><?php echo form_textarea($body); ?></td>
		<td style="color: red;"><?php echo form_error($body['name']); ?><?php echo isset($errors[$body['name']])?$errors[$body['name']]:''; ?></td>
	</tr>
	

	
</table>
<?php echo form_submit('create post', 'Create post'); ?>
<?php echo form_close(); ?>
