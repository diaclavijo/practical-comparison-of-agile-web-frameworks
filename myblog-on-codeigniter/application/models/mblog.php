<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Blog
 *
 * This model represents user authentication data. It operates the following tables:
 * - blog data
 *
 */
class MBlog extends CI_Model
{
    public $rules = array(
        array(
			'field' => 'title',
			'label' => 'Title',
            'rules' => 'trim|required|xss_clean|max_length[255]'
        ),
        array(
			'field' => 'description',
			'label' => 'Description',
            'rules' => 'trim|xss_clean|max_length[1000]'
        )
    );

    private $table_name	= 'blog';			// blog table name

    
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
		$data['user_id'] = $this->tank_auth->get_user_id();//always to the crrent user
		if ($this->db->insert($this->table_name, $data)) {
			return True;
		}
		return False;
	}

	function get_blog_by_user_id($user_id){
		$query = $this->db->get_where(
					$this->table_name,
					array('user_id' => $user_id)
				);
		
		if ($query->num_rows() == 1) return $query->row_array();
		return NULL;
	}

	function get_blog_by_id($id){
		$query = $this->db->get_where(
					$this->table_name,
					array('id' => $id)
				);
		
		if ($query->num_rows() == 1) return $query->row_array();
		return NULL;
	}

	function update($id, $data){
		$this->db->where('id', $id);
        return $this->db->update($this->table_name, $data);      

	}

	function delete($id){
		$this->db->where('id', $id);
		$this->db->delete($this->table_name);
		if ($this->db->affected_rows() > 0) {
			$this->delete_posts($id);
			return TRUE;
		}
		return FALSE;
	}

	function delete_by_user_id($user_id){
		$this->db->where('user_id', $user_id);
		$query = $this->db->get($this->table_name);
		$blog = $query->row_array();
		$this->db->where('user_id', $user_id);
		$this->db->delete($this->table_name);
		if ($this->db->affected_rows() > 0) {
			$this->delete_posts($blog['id']);
			return TRUE;
		}
		return FALSE;
	}

	private function delete_posts($blog_id)
    {
        $this->load->model('mpost');
        $this->mpost->delete_posts_from_blog_id($blog_id);
    }

	

}

/* End of file users.php */
/* Location: ./application/models/auth/users.php */
