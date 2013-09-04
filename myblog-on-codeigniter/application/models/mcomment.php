<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Comment
 *
 * This model represents user authentication data. It operates the following tables:
 * - comment
 *
 */
class MComment extends CI_Model
{
    public $rules = array(
        array(
			'field' => 'username',
			'label' => 'username',
            'rules' => 'trim|required|xss_clean|max_length[255]'
        ),
        array(
			'field' => 'website',
			'label' => 'website',
            'rules' => 'trim|xss_clean|max_length[255]'
        ),
        array(
			'field' => 'email',
			'label' => 'email',
            'rules' => 'trim|valid_email|xss_clean|max_length[255]|required'
        ),
        array(
			'field' => 'body',
			'label' => 'body',
            'rules' => 'trim|xss_clean|required'
        )
    );

    private $table_name	= 'comment';		// comment table name

    
	function __construct()
	{
		parent::__construct();
		$this->load->database();
	}
	/**     
	 * Create new comment record
	 *
	 * @param $data    array  
	 * @return	array
	 */
	function create($data)
	{
		
		if ($this->db->insert($this->table_name, $data)) {
			return True;
		}
		return False;
	}

	function get_comments_by_post_id($post_id)
	{
		$this->db->order_by('posted_on','desc');
		$query = $this->db->get_where(
					$this->table_name,
					array('post_id' => $post_id)
				);
		
		if ($query->num_rows() > 0) return $query->result_array();
		return NULL;
	}

	function get_comment_by_id($id)
	{
		$query = $this->db->get_where(
					$this->table_name,
					array('id' => $id)
				);
		
		if ($query->num_rows() == 1) return $query->row_array();
		return NULL;
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

	function update_all_where_user_id_equal($user_id, $data)
	{
		$this->db->where('user_id', $user_id);
		$this->db->update($this->table_name, $data);
		if ($this->db->affected_rows() > 0) {
			return TRUE;
		}
		return FALSE;
	}

	function get_total_comments_from_post($post_id)
	{
		
		$query = $this->db->get_where(
					$this->table_name,
					array('post_id' => $post_id)
				);

		return $query->num_rows();
	}
}

/* End of file users.php */
/* Location: ./application/models/auth/users.php */
