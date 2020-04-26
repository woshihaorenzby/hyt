/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	config.language = 'zh-cn';
	config.filebrowserBrowseUrl = ctxPath+'/js/ckeditor/uploader/browse.jsp';
	config.filebrowserImageBrowseUrl = ctxPath+'/js/ckeditor/uploader/browse.jsp?type=Images';
	config.filebrowserFlashBrowseUrl = ctxPath+'/js/ckeditor/uploader/browse.jsp?type=Flashs';
	config.filebrowserUploadUrl = ctxPath+'/js/ckeditor/uploader/upload.jsp';
	config.filebrowserImageUploadUrl = ctxPath+'/ckeditor/uploadImgFile';
	config.filebrowserFlashUploadUrl = ctxPath+'/js/ckeditor/uploader/upload.jsp?type=Flashs';
	config.filebrowserWindowWidth = '640';
	config.filebrowserWindowHeight = '480';
	config.width = 600;
	config.height = 600;
	config.toolbar_A =
		[
			['Source'],
			['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
			['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
			'/',
			['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
			['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
			['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
			['Link','Unlink','Anchor'],
			['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
			'/',
			['Styles','Format','Font','FontSize'],
			['TextColor','BGColor'],
			['Maximize', 'ShowBlocks']
		];
	config.toolbar = 'A';
};
