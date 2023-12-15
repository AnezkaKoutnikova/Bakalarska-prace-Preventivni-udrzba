// tento soubor ukazuje použití DataTabels na tabulce s id LocationTable

$(document).ready(function (){
    
    $("#locationTable").DataTable({
        "language": {
            "url": '/addons/cs.json'
        },
        columnDefs: [ { orderable: false, targets: [0,1,2,3,4,5] },
                    {
                        target: 0,
                        visible: false,
                        searchable: false,
                    },
                    {
                      target: 6,
                      visible: false,
                      searchable: false,
                  }],
        pageLength: getTableRowLength(),
        lengthMenu: [7,10,15,20],
       
        //deferRender: true,
        order: [[ 6, 'desc' ],[ 0, 'desc' ], [ 3, 'desc' ], [ 4, 'desc' ]],
        initComplete: function(settings, json) {
            $("#locationTable").removeClass("d-none")
          }
    })
