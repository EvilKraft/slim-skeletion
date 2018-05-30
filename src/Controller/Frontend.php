<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Controller;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \Xandros15\SlimPagination\Pagination;
use \Xandros15\SlimPagination\PageList;

class Frontend extends BaseController
{
    public function index(Request $request, Response $response, Array $args) {

        $data = array();

        $data['blog_container1'] = $this->renderer->fetch('Frontend/Blog/blog_stile1.twig', $this->getPosts(8, 6));
        $data['blog_container4'] = $this->renderer->fetch('Frontend/Blog/blog_stile4.twig', $this->getPosts(8, 6));
        $data['blog_container5'] = $this->renderer->fetch('Frontend/Blog/blog_stile5.twig', $this->getPosts(8, 6));

        return $this->renderPage($response, 'Frontend/index.twig', $data);
    }

    public function about(Request $request, Response $response, Array $args) {

        $data = $this->getPage('about');

        return $this->renderPage($response, 'Frontend/page.twig', $data);
    }

    public function rules(Request $request, Response $response, Array $args) {

        $data = $this->getPage('rules');

        return $this->renderPage($response, 'Frontend/page.twig', $data);
    }

    public function contact(Request $request, Response $response, Array $args) {

        if($request->isPost()) {
            $vars = $request->getParsedBody();

            $stmt = $this->db->prepare("SELECT * FROM users WHERE login = 'admin'");
            $stmt->execute();
            $admin = $stmt->fetch();

            $emailFrom = array($vars['email'] => $vars['name']);
            $emailTo   = array($admin['email'] => $admin['name']);
            $emailBody = $this->renderer->fetch('Emails/contacts.twig', array(
                'from' => $vars['name'].' <'.$vars['email'].'>',
                'text' => $vars['text']
            ));

            // Setting all needed info and passing in my email template.
            $message = (new \Swift_Message($this->trans('Contacts').': '.$vars['name']))
                ->setFrom($emailFrom)
                ->setTo($emailTo)
                ->setBody($emailBody)
                ->setContentType("text/html");

            // Send the message
            $result = $this->mailer->send($message);

            if($result == 1){
                $this->flash->addMessage('success', $this->trans('Email was send'));
            }else{
                $this->flash->addMessage('error', $this->trans('An error occurred. Please contact administrator'));
            }
            return $response->withStatus(302)->withHeader('Location', $this->router->pathFor('home', ['lang' => $this->lang]));
        }

        $data = $this->getPage('contacts');

        return $this->renderPage($response, 'Frontend/contact.twig', $data);
    }

    public function blog(Request $request, Response $response, Array $args) {
        $data = array();

        $options = array(
            Pagination::OPT_PARAM_NAME  => 'page',
            Pagination::OPT_PARAM_TYPE  => PageList::PAGE_ATTRIBUTE,
            Pagination::OPT_PER_PAGE    => 10,
            Pagination::OPT_SIDE_LENGTH => 3,
        );

        $categoryId = $request->getAttribute('id', 0);
        $page       = $request->getAttribute($options[Pagination::OPT_PARAM_NAME], 1);
        $offset     = $options[Pagination::OPT_PER_PAGE] * ($page - 1);

        $sql = "SELECT I.industryId, IL.name FROM industries I INNER JOIN industries_lang IL ON I.industryId = IL.industryId WHERE I.industryId = ? AND IL.lang=?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$categoryId, $this->lang]);
        if(!$data['industry'] = $stmt->fetch()){
            throw new \Slim\Exception\NotFoundException($request, $response);
        }

        $countSQL = "SELECT COUNT(*) total
                     FROM posts P
                     INNER JOIN posts_lang L ON L.postId = P.postId AND L.lang = '".$this->lang."'
                     INNER JOIN users U ON P.userId = U.userId
                     INNER JOIN posts_industries PI ON PI.postId = P.postId AND PI.industryId = :industryId";

        $dataSQL  = "SELECT P.*, L.*, U.name, PF.file
                     FROM posts P
                     INNER JOIN posts_lang L ON L.postId = P.postId AND L.lang = '".$this->lang."'
                     LEFT JOIN (
                         SELECT A.postId, A.file
                         FROM posts_files A
                         INNER JOIN (
                             SELECT MAX(a.fileId) fileId, a.postId 
                             FROM posts_files a 
                             WHERE type LIKE 'image%' 
                             GROUP BY a.postId
                         ) B ON A.fileId = B.fileId                 
                     ) PF ON PF.postId = P.postId
                     INNER JOIN users U ON P.userId = U.userId
                     INNER JOIN posts_industries PI ON PI.postId = P.postId AND PI.industryId = :industryId
                     ORDER BY P.createdAt DESC
                     LIMIT :limit OFFSET :offset";

        $countQuery = $this->db->prepare($countSQL);
        $dataQuery  = $this->db->prepare($dataSQL);

        $countQuery->bindValue(':industryId', $categoryId,                        \PDO::PARAM_INT);

        $dataQuery->bindValue(':industryId', $categoryId,                        \PDO::PARAM_INT);
        $dataQuery->bindValue(':limit',      $options[Pagination::OPT_PER_PAGE], \PDO::PARAM_INT);
        $dataQuery->bindValue(':offset',     $offset,                            \PDO::PARAM_INT);

        $countQuery->execute();
        $dataQuery->execute();

        $options[Pagination::OPT_TOTAL] = $countQuery->fetch()['total'];
        $data['items']                  = $dataQuery->fetchAll();

        $pagination = new Pagination($request, $this->router, $options);
        $data['pagination'] = $this->renderer->fetch('Frontend/pagination.twig', ['pagination' => $pagination]);

        return $this->renderPage($response, 'Frontend/blog.twig', $data);
    }

    public function post(Request $request, Response $response, Array $args) {
        $data = array(
            'images' => [],
            'files' => [],
        );

        $sql  = "SELECT 
                    P.*, L.*, 
                    U.name, U.phone, U.email, U.site, U.facebook,
                    C.name as city, C.country,
                    PF.file
                 FROM posts P
                 INNER JOIN posts_lang L ON L.postId = P.postId AND L.lang = ?
                 LEFT JOIN (
                     SELECT A.postId, A.file
                     FROM posts_files A
                     INNER JOIN (
                         SELECT MAX(a.fileId) fileId, a.postId 
                         FROM posts_files a 
                         WHERE type LIKE 'image%' 
                         GROUP BY a.postId
                     ) B ON A.fileId = B.fileId                 
                 ) PF ON PF.postId = P.postId
                 INNER JOIN users U ON P.userId = U.userId
                 LEFT JOIN cities C ON C.cityId = U.cityId
                 WHERE P.postId = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$this->lang, $args['id']]);
        if(!$data['item'] = $stmt->fetch()){
            throw new \Slim\Exception\NotFoundException($request, $response);
        }

        $sql = "SELECT I.industryId, IL.name 
                FROM industries I 
                INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?
                INNER JOIN posts_industries PI ON PI.industryId = I.industryId
                WHERE PI.postId = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$this->lang, $args['id']]);
        $data['item']['industries'] = $stmt->fetchAll();

        $sql = "SELECT * FROM posts_files WHERE postId = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$args['id']]);

        while($file = $stmt->fetch()){
            if(\Helpers\Helpers::isImageMIME($file['type'])){
                $data['item']['images'][] = $file;
            }else{
                $data['item']['files'][] = $file;
            }
        }

        return $this->renderPage($response, 'Frontend/post.twig', $data);
    }

    protected function renderPage(Response $response, $template, Array $data = null){
        $stmt = $this->db->prepare("SELECT I.industryId, IL.name FROM industries I INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?");
        $stmt->execute([$this->lang]);
        $data['industries'] = $stmt->fetchAll();

        $data['recent_posts'] = $this->recentPosts();

        return $this->renderer->render($response, $template, $data);
    }

    protected function getPage($alias){
        $sql = "SELECT P.*, L.title, L.keywords, L.description, L.text
                FROM pages P
                INNER JOIN pages_lang L ON L.pageId=P.pageId AND L.lang=?
                WHERE alias=?";

        $stmt = $this->db->prepare($sql);
        $stmt->execute([$this->lang, $alias]);
        $item = $stmt->fetch();

        $data = array(
            'title'       => $item['title'],
            'keywords'    => $item['keywords'],
            'description' => $item['description'],
            'text'        => $item['text'],
        );

        return $data;
    }


    protected function getPosts($industryId, $limit = 10, $offset = 0){
        $data = array();

        $industryId = (int) $industryId;

        $sql = "SELECT I.industryId, IL.name FROM industries I INNER JOIN industries_lang IL ON I.industryId = IL.industryId WHERE I.industryId = ? AND IL.lang=?";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$industryId, $this->lang]);
        $data['industry'] = $stmt->fetch();

        $sql  = "SELECT P.*, L.*, U.name, PF.file
                 FROM posts P
                 INNER JOIN posts_lang L ON L.postId = P.postId AND L.lang = '".$this->lang."'
                 LEFT JOIN (
                     SELECT A.postId, A.file
                     FROM posts_files A
                     INNER JOIN (
                         SELECT MAX(a.fileId) fileId, a.postId 
                         FROM posts_files a 
                         WHERE type LIKE 'image%' 
                         GROUP BY a.postId
                     ) B ON A.fileId = B.fileId                 
                 ) PF ON PF.postId = P.postId
                 INNER JOIN users U ON P.userId = U.userId
                 INNER JOIN posts_industries PI ON PI.postId = P.postId AND PI.industryId = :industryId
                 
                 ORDER BY P.createdAt DESC
                 LIMIT :limit OFFSET :offset";

        $stmt = $this->db->prepare($sql);
        $stmt->bindValue(':industryId',  $industryId,  \PDO::PARAM_INT);
        $stmt->bindValue(':limit',       $limit,       \PDO::PARAM_INT);
        $stmt->bindValue(':offset',      $offset,      \PDO::PARAM_INT);
        $stmt->execute();

        $data['items'] = $stmt->fetchAll();

        return $data;
    }

    protected function recentPosts($limit = 10, $offset = 0){
        $data = array(
            'title' => $this->trans('Latest Posts'),
        );

        $sql  = "SELECT P.*, L.*, U.name, PF.file
                 FROM posts P
                 INNER JOIN posts_lang L ON L.postId = P.postId AND L.lang = '".$this->lang."'
                 LEFT JOIN (
                     SELECT A.postId, A.file
                     FROM posts_files A
                     INNER JOIN (
                         SELECT MAX(a.fileId) fileId, a.postId 
                         FROM posts_files a 
                         WHERE type LIKE 'image%' 
                         GROUP BY a.postId
                     ) B ON A.fileId = B.fileId                 
                 ) PF ON PF.postId = P.postId
                 INNER JOIN users U ON P.userId = U.userId

                 ORDER BY P.createdAt DESC
                 LIMIT :limit OFFSET :offset";

        $stmt = $this->db->prepare($sql);
        $stmt->bindValue(':limit',       $limit,       \PDO::PARAM_INT);
        $stmt->bindValue(':offset',      $offset,      \PDO::PARAM_INT);
        $stmt->execute();

        $data['items'] = $stmt->fetchAll();

        return $data;
    }
}