<?php
/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

namespace Handlers;


use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Http\Body;
use Monolog\Logger;
use Slim\Views\Twig;

final class ErrorHandler extends \Slim\Handlers\Error
{
    protected $logger;
    protected $renderer;

    public function __construct($displayErrorDetails = false, Logger $logger, Twig $renderer)
    {
        $this->logger   = $logger;
        $this->renderer = $renderer;
        parent::__construct($displayErrorDetails);
    }

    public function __invoke(Request $request, Response $response, \Exception $exception)
    {
        // Log the message
        $msg  = str_replace("\n", " ", $exception->getMessage())."\n";
        $msg .= sprintf("type: %s\n", get_class($exception));
        $msg .= sprintf("code: %s\n", $exception->getCode());
       // $msg .= sprintf("message: %s\n", str_replace("\n", " ", $exception->getMessage()));
        $msg .= sprintf("file: %s\n", $exception->getFile());
        $msg .= sprintf("line: %s\n", $exception->getLine());
        $msg .= sprintf("trace: \n\t%s", str_replace("\n", "\n\t", $exception->getTraceAsString()));

        $this->logger->critical($msg);


        $contentType = $this->determineContentType($request);
        switch ($contentType) {
            case 'application/json':
                $output = $this->renderJsonErrorMessage($exception);
                break;

            case 'text/xml':
            case 'application/xml':
                $output = $this->renderXmlErrorMessage($exception);
                break;

            case 'text/html':
                $output = $this->renderer->fetch('Errors/500.twig', array(
                    'output' => $this->renderHtmlErrorMessage($exception)
                ));
                break;

            default:
                throw new UnexpectedValueException('Cannot render unknown content type ' . $contentType);
        }

        $body = new Body(fopen('php://temp', 'r+'));
        $body->write($output);

        return $response
            ->withStatus(500)
            ->withHeader('Content-type', $contentType)
            ->withBody($body);

    }

    // create a JSON error string for the Response body
    protected function renderJsonErrorMessage(\Exception $exception)
    {
        $data = array(
            'status' => 'error',
            'data' => [],
            'errors' => [],
        );

        if ($this->displayErrorDetails) {
            do {
                $data['errors'][] = [
                    'type' => get_class($exception),
                    'code' => $exception->getCode(),
                    'message' => $exception->getMessage(),
                    'file' => $exception->getFile(),
                    'line' => $exception->getLine(),
                    'trace' => explode("\n", $exception->getTraceAsString()),
                ];
            } while ($exception = $exception->getPrevious());
        }else{
            $data['errors'][] = array(
                'code' => $exception->getCode(),
                'message' => $exception->getMessage(),
            );
        }

        return json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);
    }

    protected function renderHtmlErrorMessage(\Exception $exception)
    {
        if ($this->displayErrorDetails) {
            $html = '<p>The application could not run because of the following error:</p>';
            $html .= '<h2>Details</h2>';
            $html .= $this->renderHtmlException($exception);

            while ($exception = $exception->getPrevious()) {
                $html .= '<h2>Previous exception</h2>';
                $html .= $this->renderHtmlExceptionOrError($exception);
            }
        } else {
            $html = '<p>A website error has occurred. Sorry for the temporary inconvenience.</p>';
        }

        return $html;
    }
}