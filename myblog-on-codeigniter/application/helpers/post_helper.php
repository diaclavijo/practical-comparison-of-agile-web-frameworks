<?

function show_post ($post) {
		$ci = get_instance();
		$author = $ci->mpost->get_post_author_by_blog_id($post['blog_id']);
		
		$response = anchor(
					'/'.$author.'/'.$post['permalink'],
					"<h2>".$post['title']."</h2>\n"
					);
		$response .= "<h3> Created by ".anchor('/'.$author,$author)." on ".$post['posted_on']."</h3>\n";
		$response .= "<p>".$post['body']."</p>\n";
        $response .= "<small> number of comments "
					.$ci->mcomment->get_total_comments_from_post($post['id'])
					."  </small>" ;

		$current_user = $ci->tank_auth->current_user();
		if ( $current_user['username'] == $author ) //show button options only to the owners of the post 
		{
			
			$response .= form_open('post/update/'.$post['permalink']
						, array('method' => 'get'));
			$response .= form_submit('update', 'Update Post');
			$response .= form_close();
			
			$response .= form_open('post/delete/'.$post['permalink']);
			$response .= form_submit('delete', 'Delete Post');
			$response .= form_close();
		}

        return $response;
}

?>
