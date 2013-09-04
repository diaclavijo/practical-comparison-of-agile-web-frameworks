<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
|
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|
|	example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
|	http://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There area two reserved routes:
|
|	$route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
|	$route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router what URI segments to use if those provided
| in the URL cannot be matched to a valid route.
|
*/
$route['auth/change_password'] = 'auth/change_password';
$route['auth/update'] = 'auth/update';
$route['auth/register'] = 'auth/register';
$route['auth/login'] = 'auth/login';
$route['auth/logout'] = 'auth/logout';
$route['auth/delete'] = 'auth/delete';


$route['blog/create'] = 'blog/create';
$route['blog/update'] = 'blog/update';
$route['blog/delete'] = 'blog/delete';

$route['post/create'] = 'post/create';
$route['post/update/(:any)'] = 'post/update/$1';
$route['post/delete/(:any)'] = 'post/delete/$1';

$route['comment/delete/(:num)'] = 'comment/delete/$1';

$route['default_controller'] = 'post/index';

$route['(:any)/(:any)'] = 'post/show/$2';
$route['(:any)'] = 'blog/show/$1';

$route['404_override'] = '';


/* End of file routes.php */
/* Location: ./application/config/routes.php */
