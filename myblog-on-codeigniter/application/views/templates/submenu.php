<div id='submenu'>
	<ul>
		<?php if ($this->tank_auth->is_logged_in()){ ?>

			<?php if ($this->tank_auth->has_blog()){ ?>
				<li><?= anchor('/blog/update', 'Update blog'); ?>  </li>
			<? } ?>
			<li><?= anchor('/auth/change_password/', 'Change password'); ?>  </li>
		<? } ?>
		
	</ul>
</div>
