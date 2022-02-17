export default class Bests {
  constructor(){
    console.log('bests');
  }
  
  getContent(link, count){
    $.ajax({
      method: 'get',
      url: Routes.get_content_bests_path(),
      data: {
        link: link
      },
      success: (response) => {
        console.log($(`#news_content_${count}`), response.content);
        $(`#news_content_${count}`)[0].innerText = response.content;
      },
      error: () => {
        alert('Wrong link');
      }
    })
  }
}
