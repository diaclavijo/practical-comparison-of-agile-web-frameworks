<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Blog extends CI_Controller
{
    
    function __construct()
	{
		parent::__construct();

		$this->load->helper(array('form', 'url', 'array', 'html', 'post'));
		$this->load->library('form_validation');
		$this->load->library('tank_auth');
        $this->load->model('mblog');
        $this->load->model('users');
	}
    function create()
    {
        $this->tank_auth->logged_in_or_redirect();
        $data['title'] = 'Create blog';

        //set rules
        $this->form_validation->set_rules($this->mblog->rules); 

        if ($this->form_validation->run())
        {
            $blog = elements(array('title', 'description'), $this->input->post());
            
            if ($this->mblog->create($blog))
            {
                $this->session->set_flashdata('message', 'Blog successfully created');
                redirect('/'.$this->tank_auth->get_username());
            
            }else{ //some error
                
            }
        }

        $this->load->view('templates/header', $data);
        $this->load->view('blog/create', $data);
    }

    function show($username)
    {
		$this->load->model('mcomment');
        if (
            $user = $this->users->get_user_by_username($username) AND
            $blog = $this->mblog->get_blog_by_user_id($user['id'])
            )
        {
            $data = elements(array('title','description'), $blog);

            $this->load->model('mpost');
            $data['posts'] = $this->mpost->get_posts_by_blog_id($blog['id']);
            
            $this->load->view('templates/header', $data);
            $this->load->view('blog/show', $data);
        }else{//does not exists 
            show_404();
        }

    }

    function update()
    {
        $this->tank_auth->logged_in_or_redirect();

        if ($blog = $this->tank_auth->has_blog())
        {
            $data = elements(array('title','description'), $blog);
            
             //set rules
            $this->form_validation->set_rules($this->mblog->rules); 
            
            if ($this->form_validation->run())
            {
                $new_values = elements(array('title', 'description'), $this->input->post());
                
                if ($this->mblog->update($blog['id'],$new_values))
                {
                    $this->session->set_flashdata('message', 'Blog successfully updated');
                    redirect('/blog/update');
                
                }else{ //some error
                }
            }

            $this->load->view('templates/header', $data);
            $this->load->view('templates/submenu', $data);
            $this->load->view('blog/update', $data);
        }else{
            redirect('/blog/create');
        }
    }

    function delete()
    {
        $this->tank_auth->logged_in_or_redirect();
        if ($blog = $this->tank_auth->has_blog())
        {
            if ($this->mblog->delete($blog['id']))
            {
                $this->session->set_flashdata('message', 'Blog successfully deleted');
                redirect('/');
            }else{
                $this->session->set_flashdata('message', 'There was some error trying to delete it, please contact an administrator');
                redirect('/');
            }
        }else{
            redirect('/blog/create');
        }
    }
}
