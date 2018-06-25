<?php
/**
 * Created by PhpStorm.
 * User: Kraft
 * Date: 22.06.2018
 * Time: 11:52
 */

namespace Helpers;

use Symfony\Component\Translation\MessageCatalogueInterface;

class TranslatorLogger implements \Psr\Log\LoggerInterface
{
    protected $file;
    protected $data;

    public function __construct($file)
    {
        if(!file_exists($file)){
            file_put_contents($file, "<?php\n\nreturn array();\n");
        }

        $this->file = $file;
        $this->data = include $file;
    }

    public function checkTranslations(MessageCatalogueInterface $MessageCatalogue){
        $locale = $MessageCatalogue->getLocale();

        if(!array_key_exists($locale, $this->data)){
            return;
        }

        foreach ($this->data[$locale] as $domain => $translations){
            foreach (array_keys($translations) as $id ){
                if($MessageCatalogue->has($id, $domain)){
                    unset($this->data[$locale][$domain][$id]);
                }
            }
        }

        file_put_contents($this->file, "<?php\n\nreturn ".var_export($this->data, true).";\n");
    }

    protected function process($message, array $context = array()){
        //$this->data[$context['locale']][$context['domain']][$context['id']] = $message;
        $this->data[$context['locale']][$context['domain']][$context['id']] = $context['id'];

        file_put_contents($this->file, "<?php\n\nreturn ".var_export($this->data, true).";\n");
    }

    /**
     * System is unusable.
     *
     * @param string $message
     * @param array $context
     *
     * @return void
     */
    public function emergency($message, array $context = array())
    {
        // TODO: Implement emergency() method.
        $this->process($message, $context);
    }

    /**
     * Action must be taken immediately.
     *
     * Example: Entire website down, database unavailable, etc. This should
     * trigger the SMS alerts and wake you up.
     *
     * @param string $message
     * @param array $context
     *
     * @return void
     */
    public function alert($message, array $context = array())
    {
        // TODO: Implement alert() method.
        $this->process($message, $context);
    }

    /**
     * Critical conditions.
     *
     * Example: Application component unavailable, unexpected exception.
     *
     * @param string $message
     * @param array $context
     *
     * @return void
     */
    public function critical($message, array $context = array())
    {
        // TODO: Implement critical() method.
        $this->process($message, $context);
    }

    /**
     * Runtime errors that do not require immediate action but should typically
     * be logged and monitored.
     *
     * @param string $message
     * @param array $context
     *
     * @return void
     */
    public function error($message, array $context = array())
    {
        // TODO: Implement error() method.
        $this->process($message, $context);
    }

    /**
     * Exceptional occurrences that are not errors.
     *
     * Example: Use of deprecated APIs, poor use of an API, undesirable things
     * that are not necessarily wrong.
     *
     * @param string $message
     * @param array $context
     *
     * @return void
     */
    public function warning($message, array $context = array())
    {
        // TODO: Implement warning() method.
        $this->process($message, $context);
    }

    /**
     * Normal but significant events.
     *
     * @param string $message
     * @param array $context
     *
     * @return void
     */
    public function notice($message, array $context = array())
    {
        // TODO: Implement notice() method.
        $this->process($message, $context);
    }

    /**
     * Interesting events.
     *
     * Example: User logs in, SQL logs.
     *
     * @param string $message
     * @param array $context
     *
     * @return void
     */
    public function info($message, array $context = array())
    {
        // TODO: Implement info() method.
        $this->process($message, $context);
    }

    /**
     * Detailed debug information.
     *
     * @param string $message
     * @param array $context
     *
     * @return void
     */
    public function debug($message, array $context = array())
    {
        // TODO: Implement debug() method.
        $this->process($message, $context);
    }

    /**
     * Logs with an arbitrary level.
     *
     * @param mixed $level
     * @param string $message
     * @param array $context
     *
     * @return void
     */
    public function log($level, $message, array $context = array())
    {
        // TODO: Implement log() method.
        $this->process($message, $context);
    }
}