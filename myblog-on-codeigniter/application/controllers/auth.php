<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Auth extends CI_Controller
{
	function __construct()
	{
		parent::__construct();

		$this->load->helper(array('form', 'url', 'array', 'html'));
		$this->load->library('form_validation');
		$this->load->library('security');
		$this->load->library('tank_auth');
		$this->lang->load('tank_auth');
	}


    function upload_avatar()
    {
        $this->tank_auth->logged_in_or_redirect();
        $data['title'] = 'Update user';
        
        $user = $this->tank_auth->current_user();     //load user from database
        $user_profile = $this->tank_auth->current_profile();

        $data += elements(array('username', 'email' ), $user); //you removed a height from here, if there is any problem, get it back, just add to the end ", 'height' 
        $data += elements(array('website', 'avatar'), $user_profile);

        $avatar_rules = array( //avatar rules
            'upload_path' => './avatars/',
            'allowed_types' => 'gif|jpg|png|jpeg',
            'max_size' => '1000'
            );
        $this->load->library('upload', $avatar_rules);
    
        if ($this->upload->do_upload('avatar'))
        {
            $file_data = $this->upload->data();
            $user_profile['avatar'] = $file_data['file_name'];
            $this->tank_auth->update_user_profile($user_profile);
            $this->session->set_flashdata('message', 'Avatar successfully updated');
            redirect('/auth/update');
        }
        else
        {
            $data['errors']['avatar'] = $this->upload->display_errors();
        }
        $this->load->view('templates/header', $data);
        $this->load->view('auth/update', $data);
    
    }
    function update()
    {
        $this->tank_auth->logged_in_or_redirect();
        $data['title'] = 'Update user';

        $user = $this->tank_auth->current_user();     //load user from database
        $user_profile = $this->tank_auth->current_profile();

        $data += elements(array('username', 'email', 'height'), $user);
        $data += elements(array('website', 'avatar'), $user_profile);

        $user_rules = 'trim|required|xss_clean|min_length['.$this->config->item('username_min_length', 'tank_auth').']|max_length['.$this->config->item('username_max_length', 'tank_auth').']|alpha_dash'; // form rules
        $email_rules = 'trim|required|xss_clean|valid_email';
        
        if ($this->input->post('username') != $user['username'])
            $user_rules = $user_rules.'|is_unique[users.username]';

        if ($this->input->post('email') != $user['email'])
            $email_rules = $email_rules.'|is_unique[users.email]';

        $this->form_validation->set_rules('username', 'Username', $user_rules);
        $this->form_validation->set_rules('email', 'Email', $email_rules);
        $this->form_validation->set_rules('website', 'Website', 'trim|xss_clean');

        if ($this->form_validation->run()) {								// validation ok
            if (
                ($this->tank_auth->update_user(
                    array(
                        'username' => $this->form_validation->set_value('username'),
                        'email' => $this->form_validation->set_value('email')
                        )
                    )
                ) and ($this->tank_auth->update_user_profile(
                    array(
                        'website' => $this->form_validation->set_value('website')
                        )
                    )
                )
               ) {									// success


                $this->session->set_flashdata('message', 'Successfully updated');
                redirect('/auth/update');
                    
            }
        } else {
            $errors = $this->tank_auth->get_error_message();
            foreach ($errors as $k => $v)	$data['errors'][$k] = $this->lang->line($v);
        }
        
        $this->load->view('templates/header', $data);
        $this->load->view('templates/submenu', $data);
        $this->load->view('auth/update', $data);
    
    }

	function index()
	{
		if ($message = $this->session->flashdata('message')) {
			$this->load->view('auth/general_message', array('message' => $message));
		} else {
			redirect('/auth/login/');
		}
	}

	/**
	 * Login user on the site
	 *
	 * @return void
	 */
	function login()
	{
        $data['title'] = 'Login';
		if ($this->tank_auth->is_logged_in()) {									// logged in
			redirect('');

		} else {
			$data['login_by_username'] = ($this->config->item('login_by_username', 'tank_auth') AND
					$this->config->item('use_username', 'tank_auth'));
			$data['login_by_email'] = $this->config->item('login_by_email', 'tank_auth');

			$this->form_validation->set_rules('login', 'Login', 'trim|required|xss_clean');
			$this->form_validation->set_rules('password', 'Password', 'trim|required|xss_clean');
			$this->form_validation->set_rules('remember', 'Remember me', 'integer');

			$data['errors'] = array();

			if ($this->form_validation->run()) {								// validation ok
				if ($this->tank_auth->login(
						$this->form_validation->set_value('login'),
						$this->form_validation->set_value('password'),
						$this->form_validation->set_value('remember'),
						$data['login_by_username'],
						$data['login_by_email'])) {								// success

                    if ($this->session->flashdata('next'))
                        redirect($this->session->flashdata('next'));
                    redirect('');

				} else { //fail
					$errors = $this->tank_auth->get_error_message();
					foreach ($errors as $k => $v)	$data['errors'][$k] = $this->lang->line($v);
				}
			}
           
            if ($this->session->flashdata('next'))
                $this->session->keep_flashdata('next');
                
            $this->load->view('templates/header', $data);
			$this->load->view('auth/login_form', $data);
		}
	}

	/**
	 * Logout user
	 *
	 * @return void
	 */
	function logout()
	{
		$this->tank_auth->logout();

		$this->_show_message($this->lang->line('auth_message_logged_out'));
	}

	/**
	 * Register user on the site
	 *
	 * @return void
	 */
	function register()
	{
        $data['title'] = 'Register';
		if ($this->tank_auth->is_logged_in()) {									// logged in
			redirect('');
		} else {
			$use_username = $this->config->item('use_username', 'tank_auth');
			if ($use_username) {
				$this->form_validation->set_rules('username', 'Username', 'trim|required|xss_clean|min_length['.$this->config->item('username_min_length', 'tank_auth').']|max_length['.$this->config->item('username_max_length', 'tank_auth').']|alpha_dash');
			}
			$this->form_validation->set_rules('email', 'Email', 'trim|required|xss_clean|valid_email');
			$this->form_validation->set_rules('password', 'Password', 'trim|required|xss_clean|min_length['.$this->config->item('password_min_length', 'tank_auth').']|max_length['.$this->config->item('password_max_length', 'tank_auth').']|alpha_dash');
			$this->form_validation->set_rules('confirm_password', 'Confirm Password', 'trim|required|xss_clean|matches[password]');
			
			$data['errors'] = array();

            print $this->form_validation->set_value('password');

            if ($this->form_validation->run()) {								// validation ok
				if (!is_null($this->tank_auth->create_user(
						$use_username ? $this->form_validation->set_value('username') : '',
						$this->form_validation->set_value('email'),
						$this->form_validation->set_value('password'),
						False))) {									// success


                    if (!$this->tank_auth->login(
						$this->form_validation->set_value('username'),
						$this->form_validation->set_value('password'),
						False,
						True,
						False)
                        )
                        redirect('/auth/login');

                    $this->session->set_flashdata('message', 'Successfully registered');
                    redirect('/');
                }
            }
        }

        $errors = $this->tank_auth->get_error_message();
        foreach ($errors as $k => $v)	$data['errors'][$k] = $this->lang->line($v);
        $this->load->view('templates/header', $data);
        $this->load->view('auth/register_form', $data);
    }
	

	/**
	 * Change user password
	 *
	 * @return void
	 */
	function change_password()
	{
        $data['title'] = 'Change password';
		$this->tank_auth->logged_in_or_redirect();	// not logged in or not activated
		
        $this->form_validation->set_rules('old_password', 'Old Password', 'trim|required|xss_clean');
        $this->form_validation->set_rules('new_password', 'New Password', 'trim|required|xss_clean|min_length['.$this->config->item('password_min_length', 'tank_auth').']|max_length['.$this->config->item('password_max_length', 'tank_auth').']|alpha_dash');
        $this->form_validation->set_rules('confirm_new_password', 'Confirm new Password', 'trim|required|xss_clean|matches[new_password]');

        $data['errors'] = array();

        if ($this->form_validation->run()) {								// validation ok
            if ($this->tank_auth->change_password(
                    $this->form_validation->set_value('old_password'),
                    $this->form_validation->set_value('new_password'))) {	// success
                $this->session->set_flashdata('message', 'Successfully changed password');
                redirect('/auth/update');

            } else {														// fail
                $errors = $this->tank_auth->get_error_message();
                foreach ($errors as $k => $v)	$data['errors'][$k] = $this->lang->line($v);
            }
        }
        $this->load->view('templates/header', $data);
        $this->load->view('templates/submenu', $data);
        $this->load->view('auth/change_password_form', $data);

	}
	
	/**
	 * Delete user from the site (only when user is logged in)
	 *
	 * @return void
	 */
	function delete()
	{
        $this->tank_auth->logged_in_or_redirect();
       
        if ($this->tank_auth->delete_user()) // success
        {		
            $this->_show_message('Sucessfully unregistered');
            
        } else {														// fail
            // this is wrong, because title will not be shown, nevertheless
            // as it is a rare case, it is leaved in this way. Redirect
            // would be better choice
            $errors = $this->tank_auth->get_error_message();
            foreach ($errors as $k => $v)
                $data['errors'][$k] = $this->lang->line($v);
            $this->load->view('templates/header', $data);
            $this->load->view('auth/update', $data);
        }
	}

	/**
	 * Show info message
	 *
	 * @param	string
	 * @return	void
	 */
	function _show_message($message)
	{
        
		$this->session->set_flashdata('message', $message);
		redirect('');

	}
}


/* End of file auth.php */
/* Location: ./application/controllers/auth.php */



