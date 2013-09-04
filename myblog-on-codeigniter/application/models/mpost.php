<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Post
 *
 * This model represents post data. It operates the following tables:
 * - post data
 *
 */
class MPost extends CI_Model
{
    public $rules = array(
        array(
			'field' => 'title',
			'label' => 'title',
            'rules' => 'trim|required|xss_clean|max_length[255]'
        ),
        array(
			'field' => 'body',
			'label' => 'Body',
            'rules' => 'trim|required|xss_clean'
        )
    );

    private $table_name	= 'post';			// blog table name

    
	function __construct()
	{
		parent::__construct();
		$this->load->database();
	}
	/**     
	 * Create new blog record
	 *
	 * @param $data    array  
	 * @return	array
	 */
	function create($data)
	{
		$data['permalink'] = url_title($data['title']);
		if ($this->db->insert($this->table_name, $data)) {
			return True;
		}
		return False;
	}

	function get_post_by_id($id)
	{
		$query = $this->db->get_where(
					$this->table_name,
					array('id' => $id)
				);
		if ($query->num_rows() == 1) return $query->row_array();
		return NULL;
	}

	function get_post($permalink)
	{
		$query = $this->db->get_where(
					$this->table_name,
					array('permalink' => $permalink)
				);
		if ($query->num_rows() == 1) return $query->row_array();
		return NULL;
	}

	function total_posts(){
		return $this->db->count_all($this->table_name);
	}


	function get_posts($per_page, $offset=0)
	{
		$this->db->limit($per_page, $offset);
		$this->db->order_by('posted_on','desc');
		$query = $this->db->get($this->table_name);
		
		if ($query->num_rows() > 0) return $query->result_array();
		return NULL;
	}

	function get_posts_by_blog_id($blog_id)
	{
		$this->db->order_by('posted_on','desc');
		$query = $this->db->get_where(
					$this->table_name,
					array('blog_id' => $blog_id)
				);
		if ($query->num_rows() > 0) return $query->result_array();
		return NULL;
	}

	function get_post_author_by_blog_id($blog_id)
	{
		$this->load->model('mblog');

		$blog = $this->mblog->get_blog_by_id($blog_id);
		$user = $this->users->get_user_by_id($blog['user_id']);

		return $user['username'];
	}

	function update($id, $data){
		$this->db->where('id', $id);
        return $this->db->update($this->table_name, $data);      
	}

	function delete($id)
	{
		$this->db->where('id', $id);
		$this->db->delete($this->table_name);
		if ($this->db->affected_rows() > 0) {
			return TRUE;
		}
		return FALSE;
	}

	function get_total_posts_which_contains($text)
	{
		$this->db->or_like('title', $text);
		$this->db->or_like('body', $text);
		$this->db->from($this->table_name);
		return $this->db->count_all_results();
	}
	
	function get_posts_which_contains($text,$per_page,$offset=0)
	{
		$this->db->limit($per_page, $offset);
		$this->db->order_by('posted_on','desc');

		$this->db->or_like('title', $text);
		$this->db->or_like('body', $text);
		
		$query = $this->db->get($this->table_name);

		if ($query->num_rows() > 0) return $query->result_array();
		return NULL;
	}

	function delete_posts_from_blog_id($blog_id)
	{
		$this->db->where('blog_id', $blog_id);
		$this->db->delete($this->table_name);
		if ($this->db->affected_rows() > 0) {
			return TRUE;
		}
	
		return FALSE;
	}


}

/* End of file users.php */
/* Location: ./application/models/auth/users.php */
