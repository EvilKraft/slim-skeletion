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

    //    $data['about_tpl']    = $this->renderer->fetch('Frontend/index_about.twig',    $this->getPage('about'));
    //    $data['partners_tpl'] = $this->renderer->fetch('Frontend/index_partners.twig', $this->getPage('partners'));
    //    $data['service_tpl']  = $this->renderer->fetch('Frontend/index_service.twig',  $this->getPage('services'));
    //    $data['contact_tpl']  = $this->renderer->fetch('Frontend/index_contact.twig',  $this->getPage('contacts'));


        $stmt = $this->db->prepare("SELECT I.industryId, IL.name FROM industries I INNER JOIN industries_lang IL ON I.industryId = IL.industryId AND lang=?");
        $stmt->execute([$this->lang]);
        $data['industries'] = $stmt->fetchAll();

        return $this->renderer->render($response, 'Frontend/index.twig', $data);
    }

    public function about(Request $request, Response $response, Array $args) {

        $data = $this->getPage('about');

        return $this->renderer->render($response, 'Frontend/page.twig', $data);
    }

    public function services(Request $request, Response $response, Array $args) {

        $data = $this->getPage('services');

        return $this->renderer->render($response, 'Frontend/page.twig', $data);
    }

    public function partners(Request $request, Response $response, Array $args) {

        $data = $this->getPage('partners');

        return $this->renderer->render($response, 'Frontend/page.twig', $data);
    }

    public function rules(Request $request, Response $response, Array $args) {

        $data = $this->getPage('rules');

        return $this->renderer->render($response, 'Frontend/rules.twig', $data);
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

        return $this->renderer->render($response, 'Frontend/contact.twig', $data);
    }

    public function blog(Request $request, Response $response, Array $args) {
        $data = $this->getPage('blog');

        $options = array(
            Pagination::OPT_PARAM_NAME  => 'page',
            Pagination::OPT_PARAM_TYPE  => PageList::PAGE_ATTRIBUTE,
            Pagination::OPT_PER_PAGE    => 10,
            Pagination::OPT_SIDE_LENGTH => 3,
        );

        $page   = $request->getAttribute($options[Pagination::OPT_PARAM_NAME], 1);
        $offset = $options[Pagination::OPT_PER_PAGE] * ($page - 1);

        $countSQL = "SELECT COUNT(*) total
                     FROM blog B
                     INNER JOIN blog_lang L ON L.blogId = B.blogId AND L.lang = '".$this->lang."'
                     INNER JOIN users U ON B.userId = U.userId";

        $dataSQL  = "SELECT B.*, L.*, U.name
                     FROM blog B
                     INNER JOIN blog_lang L ON L.blogId = B.blogId AND L.lang = '".$this->lang."'
                     INNER JOIN users U ON B.userId = U.userId
                     ORDER BY B.createdAt DESC
                     LIMIT :limit OFFSET :offset";

        $countQuery = $this->db->prepare($countSQL);
        $dataQuery  = $this->db->prepare($dataSQL);
        $dataQuery->bindValue(':limit',  $options[Pagination::OPT_PER_PAGE], \PDO::PARAM_INT);
        $dataQuery->bindValue(':offset', $offset,                            \PDO::PARAM_INT);

        $countQuery->execute();
        $dataQuery->execute();

        $options[Pagination::OPT_TOTAL] = $countQuery->fetch()['total'];
        $data['items']                  = $dataQuery->fetchAll();

        $pagination = new Pagination($request, $this->router, $options);
        $data['pagination'] = $this->renderer->fetch('Frontend/pagination.twig', ['pagination' => $pagination]);

        return $this->renderer->render($response, 'Frontend/blog.twig', $data);
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


   // protected function get
}