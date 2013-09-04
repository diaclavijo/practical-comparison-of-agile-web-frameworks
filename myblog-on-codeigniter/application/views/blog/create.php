<?php

$title = array(
    'name'	=> 'title',
    'id'	=> 'title',
    'value' => set_value('title'),
    'maxlength'	=> 255,
    'size'	=> 30,
);

$description = array(
	'name'	=> 'description',
	'id'	=> 'description',
	'value'	=> set_value('description'),
	'rows'	=> 10,
	'cols'	=> 39,
);

?>
<?php echo form_open($this->uri->uri_string()); ?>

<h1> Create a blog</h1>
<table>

	<tr>
		<td><?php echo form_label('Title', $title['id']); ?></td>
		<td><?php echo form_input($title); ?></td>
		<td style="color: red;"><?php echo form_error($title['name']); ?><?php echo isset($errors[$title['name']])?$errors[$title['name']]:''; ?></td>
	</tr>

	<tr>
		<td><?php echo form_label('Description', $description['id']); ?></td>
		<td><?php echo form_textarea($description); ?></td>
		<td style="color: red;"><?php echo form_error($description['name']); ?><?php echo isset($errors[$description['name']])?$errors[$description['name']]:''; ?></td>
	</tr>
	

	
</table>
<?php echo form_submit('create blog', 'Create blog'); ?>
<?php echo form_close(); ?>
