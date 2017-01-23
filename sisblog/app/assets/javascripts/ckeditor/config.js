CKEDITOR.config.extraPlugins = 'mediaembed';
CKEDITOR.editorConfig = function (config) {

  config.toolbar_mini = [
    {name: 'clipboard', items: ['Cut','Copy','Paste','PasteText', '-','Undo','Redo']},
    // {name: 'editing', items: ['Scayt']},
    {name: 'insert', items: ['Image','Table','HorozontalRule','SpecialChar', 'MediaEmbed']},
    {name: 'align', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']},
    '/',
    {name: 'basicstyles', items: ['Bold','Italic','Underline', 'Strikethrough', 'Subscript','Superscript','Strike','-','RemoveFormat']},
    {name: 'paragraph', items: ['NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote']},
	  { name: 'styles', items: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
	  { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
  
  ];

};