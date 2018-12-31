<?php

namespace Drupal\spec_publish\Controller;

use Drupal\node\Entity\Node;

class SpecPublishController {
	public function publish() {

		//create node
		$node = Node::create([
			'type' => 'api_specification',
			'uid' => 1,
			'revision' => 0,
			'status' => TRUE,
			'promote' => 0,
			'created' => time(),
			'langcode' => 'en',
			'title' => 'My Generated Spec',
		]);
		//add content
		$node->set('body', [
			'value' => '<h1>Welcome to My Page!</h1>',
			'format' => 'basic_html'
		]);

		//add spec
		$destination = 'public://spec_publish-specs';
		file_prepare_directory($destination, FILE_CREATE_DIRECTORY);
		 
		 $spec_source = sprintf('%s/private/assets/swagger.json', \Drupal::root());
		 $spec = null;
		  
		  if (is_readable($spec_source)) {
		    $data = file_get_contents($spec_source);
			 
		   $spec = file_save_data(
			   $data,
			   $destination . '/swagger.json',
			   FILE_EXISTS_REPLACE
			 );
		 }

		if ($spec) {
		  	$node->get('field_specification')->appendItem($spec);
		}


		//save node
		$node->save();
 
		//set alias
		$source = '/node/' . $node->get('nid')->value;
		\Drupal::service('path.alias_storage')->save($source, '/my-page', 'en');

		return array(
			'#title' => 'Hello World',
			'#markup' => 'Job Done'
		);
	}
}

