
<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Comment extends CI_Controller
{
    
    function __construct()
	{
		parent::__construct();

		$this->load->helper(array('form', 'url', 'array', 'html', 'post'));
		$this->load->library('form_validation');
		$this->load->library('tank_auth');
        $this->load->model('mcomment');
		$this->load->model('mpost');
	}


    function delete($id)
    {
		
		$this->tank_auth->logged_in_or_redirect();

		$current_user = $this->tank_auth->current_user();
		
		$comment = $this->mcomment->get_comment_by_id($id);
		$post = $this->mpost->get_post_by_id($comment['post_id']);
		$author = $this->mpost->get_post_author_by_blog_id($post['blog_id']);
		if ( $current_user['username'] == $author )
		{
			if ($this->mcomment->delete($id))
			{
                $this->session->set_flashdata('message', 'Comment successfully deleted');
                redirect('/'.$current_user['username'].'/'.$post['permalink']);
            }else{
                $this->session->set_flashdata('message', 'There was some error trying to delete it, please contact an administrator');
                redirect('/');
            }
		}else{
			show_error("not authorized");
		}
	}
}

