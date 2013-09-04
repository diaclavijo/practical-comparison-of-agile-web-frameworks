<?php

$title = array(
    'name'	=> 'title',
    'id'	=> 'title',
    'value' => set_value('title',$title),
    'maxlength'	=> 255,
    'size'	=> 30,
);

$description = array(
	'name'	=> 'description',
	'id'	=> 'description',
	'value'	=> set_value('description',$description),
	'rows'	=> 10,
	'cols'	=> 39,
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
		<td><?php echo form_label('Description', $description['id']); ?></td>
		<td><?php echo form_textarea($description); ?></td>
		<td style="color: red;"><?php echo form_error($description['name']); ?><?php echo isset($errors[$description['name']])?$errors[$description['name']]:''; ?></td>
	</tr>
	

	
</table>
<?php echo form_submit('Update', 'Update blog'); ?>
<?php echo form_close(); ?>

<?php echo form_open('blog/delete'); ?>
<?php echo form_submit('delete', 'Delete blog'); ?>
<?php echo form_close(); ?>
