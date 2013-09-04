
<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Post extends CI_Controller
{
    
    function __construct()
	{
		parent::__construct();

		$this->load->helper(array('form', 'url', 'array', 'html', 'post'));
		$this->load->library('form_validation');
		$this->load->library('tank_auth');
        $this->load->model('mpost');
		$this->load->model('mblog');
		$this->load->model('mcomment');
	}
    function create()
    {
        $this->tank_auth->logged_in_or_redirect();
        $data['title'] = 'Create a Post';
        
        $this->form_validation->set_rules($this->mpost->rules);  //set rules

        if ($this->form_validation->run())
        {
			print 'hello';
			$user_id = $this->tank_auth->get_user_id();//always to the crrent user
            $blog = $this->mblog->get_blog_by_user_id($user_id); //get current blog
			
            $post = elements(array('title', 'body'), $this->input->post());
            $post['blog_id'] = $blog['id'];
            
            if ($this->mpost->create($post))
            {
                $this->session->set_flashdata('message', 'Post successfully created');
                //TODO REDIRECT TO POST
                redirect('/'.$this->tank_auth->get_username());
            
            }else{ //some error
                
            }
        }

        $this->load->view('templates/header', $data);
        $this->load->view('post/create', $data);
    }

    function index()
    {
		$data['title'] = 'My blog';

		$this->load->library('pagination');
		$config['base_url'] = 'http://localhost/index.php?'	; //had to do this, no other way 
		$config['per_page'] = 2;
		$config['page_query_string'] = TRUE;
		
		$offset = $this->input->get('per_page');
		
		$this->form_validation->set_rules(array(
			array(
				'field' => 'search',
				'label' => 'search',
				'rules' => 'trim|xss_clean|max_length[1000]'
			)));
		
		if ($search = $this->input->get('search'))
		{
			$data['search'] = $search;
			$data['posts'] = $this->mpost->get_posts_which_contains($search,$config['per_page'],$offset);
			$config['total_rows'] = $this->mpost->get_total_posts_which_contains($search);
			$config['base_url'] .= 'search='.$search;
		}else{
			$data['posts'] = $this->mpost->get_posts($config['per_page'], $offset);
			$config['total_rows'] = $this->mpost->total_posts();
		}
			
		$this->pagination->initialize($config);

		$data['pagination'] = $this->pagination->create_links();

		// In case user is logged in , his posts must be loaded
		if ($this->tank_auth->is_logged_in()){
			$this->load->model('mblog');
			$user = $this->tank_auth->current_user();
            $blog = $this->mblog->get_blog_by_user_id($user['id']);

            $data['his_posts'] = $this->mpost->get_posts_by_blog_id($blog['id']);
		}
		
        $this->load->view('templates/header', $data);
		$this->load->view('post/index', $data);
    }

    function show($permalink)
    {
		
        if ( $post = $this->mpost->get_post($permalink))
        {
            $data['post'] = elements(array('title','body','posted_on','permalink','blog_id','id'), $post);
            $data['comments'] =
				$this->mcomment->get_comments_by_post_id($post['id']);

	
				
			$comment = array();
			if ($this->tank_auth->is_logged_in() AND
				$_SERVER['REQUEST_METHOD'] == "POST")
			{
				$user = $this->tank_auth->current_user();
				$userprofile = $this->tank_auth->current_profile();
				$comment['user_id'] = $user['id'];
				$_POST['email'] = $user['email'];
				if (isset($userprofile['website'])){
					$_POST['website'] = $userprofile['website'];
				}
				$_POST['username'] = $user['username'];
			}

			$this->form_validation->set_rules($this->mcomment->rules);  //set rules

			if ($this->form_validation->run()){

				$comment += elements(
						array('username', 'website', 'email', 'body'),
						$this->input->post()
						);
				$comment['post_id'] = $post['id'];

				if ($this->mcomment->create($comment))
				{
					$this->session->set_flashdata('message', 'Comment successfully created');
					
					redirect($this->uri->uri_string());
				
				}else{ //some error
					
				}
			}
				
            $this->load->view('templates/header', $data);
            $this->load->view('post/show', $data);
        }else{//does not exists 
            show_404();
        }

    }

    function update($permalink)
    {
		
		$this->tank_auth->logged_in_or_redirect();
		
		if ( $post = $this->mpost->get_post($permalink))
        {
			$user = $this->tank_auth->current_user();
			if ( $this->mpost->get_post_author_by_blog_id($post['blog_id'])
					!=	$user['username'] )
				show_error( "Not authorized" ); //not authorized
			
            $data = elements(array('title','body','posted_on','permalink'), $post);
			
			
            $this->form_validation->set_rules($this->mpost->rules);   //set rules

			if ($this->form_validation->run())
            {
                $new_values = elements(
					array('title', 'body'),
					$this->input->post());
                
                if ($this->mpost->update($post['id'],$new_values))
                {
                    $this->session->set_flashdata('message', 'Post successfully updated');
                    redirect('/post/update/'.$permalink);
                
                }else{ //some error
                }
            }
            
            $this->load->view('templates/header', $data);
            $this->load->view('post/update', $data);
        }else{//does not exists 
            show_404();
        }
        

        
    }

    function delete($permalink)
    {
        $this->tank_auth->logged_in_or_redirect();
        if ( $post = $this->mpost->get_post($permalink))
        {
			$user = $this->tank_auth->current_user();
			if ( $this->mpost->get_post_author_by_blog_id($post['blog_id'])
					!=	$user['username'] )
				show_error( "Not authorized" ); //not authorized
				
            if ($this->mpost->delete($post['id']))
            {
                $this->session->set_flashdata('message', 'Post successfully deleted');
                redirect('/'.$user['username']);
            }else{
                $this->session->set_flashdata('message', 'There was some error trying to delete it, please contact an administrator');
                redirect('/');
            }
        }else{
            show_404();
        }
    }
}

