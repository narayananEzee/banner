<style>
    .read-more1 {
        visibility: hidden;
    }

    .read-more2 {
        visibility: hidden;
    }

    .uniquieImage2 {
        width: 477px;
        height: 257px;

    }

    #all-sp-exception-dialogs {
        width: 478px;
        min-height: 0px;
        max-height: none;
        height: 266px;

    }

    .dialog-content-page {
        width: 478px;
        min-height: 0px;
        max-height: none;
        height: 266px;
    }

    .my-custom-dialog {
        width: auto;
        min-height: 0px;
        max-height: none;
    }

    .my-custom-image {
        width: 496px;
        height: 264px;
    }


    .value.zone,
    .hidden-values.zone,
    .value.state,
    .hidden-values.state {
        width: 20%;
        /* Set a percentage width for responsiveness */
        /* Add any additional styles or adjustments here */
    }

    .btn-defaults {
        color: #333333;
        background-color: #ffffff;
        border-color: #cccccc;
        /*    background-image: linear-gradient(#f5f5f5, #f1f1f1);*/
    }

    .panel-default {
        margin-top: -10px;
        margin-bottom: 20px;
    }

    /* Media query for smaller screens */
    @media (max-width: 768px) {

        .value.zone,
        .hidden-values.zone,
        .value.state,
        .hidden-values.state {
            width: 100%;
            /* Full width on smaller screens */
        }
    }
</style>


<div class="brand_top">
    <h3>Banner</h3>
    <!-- Add this button where you want it to appear in your HTML -->
<div class="col-md-1 download">
    <button type="button" class="btn btn-primary btn-block" id="downloadButton">Download Excel</button>
</div>


</div>
<div id="all-sp-exception-dialogs" class="dialog-content-page hide"
    style="width: auto; min-height: 0px; max-height: none; height: 266px;">
    <img id="uniquieImage2" class="my-custom-image" src="" width="497px" height="266px">
</div><br>
<div class="page_content">
    <div class="row">
        <div id="contents" class="col-lg-12">
            <br>
            <!-- PAGE HEADER-->
            <div class="row noprint">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="col-md-12">
                                <form id="searchStateForm" action="" method="post" class="mt-3">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <label for="stateName">State Name</label>
                                            <select name="stateName" id="stateName" class="form-control">
                                                <option value="all">All State</option>
                                                {foreach $uniqueStateNames as $state}
                                                    <option value="{$state}">{$state}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <label for="bannerName">Banner Name</label>
                                            <select name="bannerName" id="bannerName" class="form-control">
                                                <option value="all">All Banners</option>
                                                {assign var="uniqueValues" value=[]}
                                                {foreach $mergedData as $url => $names}
                                                    {assign var="basename" value=$url|basename}
                                                    {assign var="firstWord" value=$basename|regex_replace:'/[-_].*$/':''}

                                                    {if $firstWord|in_array:$uniqueValues eq false}
                                                        <option value="{$firstWord}">{$firstWord}</option>
                                                        {append var="uniqueValues" value=$firstWord}
                                                    {/if}
                                                {/foreach}
                                            </select>
                                        </div>

                                        <div class="col-md-1 search">
                                            <input type="hidden" name="export" id="export" value="">
                                            <button type="button" class="btn btn-success btn-block custom-color"
                                                id="searchButton">Search</button>&nbsp;
                                        </div>
                                        <div class="col-md-1 clear">
                                            <input type="hidden" name="export" id="export" value="">
                                            <button type="button" class="btn btn-default btn-clear" id="clearButton"
                                                style="margin-left: -25px;">Clear</button>
                                        </div>
                                        <div class="col-md-4"></div>

                                      
                                        <div class="col-md-2">
                                       
                                        </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br>

            <table >
                <thead>
                    <tr>
                        <th>Banners</th>
                        <th colspan="7">Operator Name</th>
                        <th>Zone</th>
                        <th>State</th>
                    </tr>
                </thead>
                <tbody id="busDataBody">
                    {foreach $mergedData as $url => $names}
                        <tr>
                            <td rowspan="{$totalNames}">
                                <a href="{$url}" data-toggle="lightbox" data-gallery="example-gallery" data-max-width="600"
                                    data-max-height="400">
                                    <img src="{$url}" alt="Clicked Image" class="uniqueImage">
                                </a>
                                {assign var="basename" value=$url|basename}
                                {assign var="firstWord" value=$basename|regex_replace:'/[-_].*$/':''}
                                <h3><b>{$firstWord}</b></h3>
                            </td>

                            {assign var="chunks" value=array_chunk($names, 51)}
                            {if count($chunks) == 1}
                                <td colspan="7">
                                    {foreach from=$chunks[0] item=name}
                                        <div>{$name.code}</div>
                                    {/foreach}
                                </td>
                            {else}
                                {foreach from=$chunks item=chunk}
                                    <td>
                                        {foreach from=$chunk item=name}
                                            <div>{$name.code}</div>
                                        {/foreach}
                                    </td>
                                {/foreach}
                            {/if}
                            <td>
                                {assign var="uniqueZones" value=array_unique(array_column($names, 'zone'))}
                                {foreach from=$uniqueZones item=zone}
                                    <div>{$zone}</div>
                                {/foreach}
                            </td>
                            <td>
                                {assign var="uniqueStateNames" value=array_unique(array_column($names, 'stateName'))}
                                {foreach from=$uniqueStateNames item=state}
                                    <div>{$state}</div>
                                {/foreach}
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
<div style="display:none;" class="temp-container"></div>



<script>
     var val = $mergedData|json_encode
    console.log(val);
    
    $(document).on('click', function(event) {
      
        var dialog = $('#all-sp-exception-dialogs');
        if (!dialog.is(event.target) && dialog.has(event.target)
            .length === 0 && !$('.uniqueImage').is(event
                .target)) {
            dialog.dialog('close');
        }
    });

    $(document).on('click', '[data-toggle="lightbox"]', function(event) {
        event.preventDefault();
        // $(this).ekkoLightbox();
    });
   
  // Place this script in your existing <script> tag or include it in your template
    $('#searchButton').on('click', function() {
        var selectedState = $('#stateName').val();
        var selectedBanner = $('#bannerName').val();

        $('tbody tr').hide();

        if (selectedState === 'all' && selectedBanner === 'all') {
            $('tbody tr').show();
        } else {
            var stateRows = selectedState === 'all' ? $('tbody tr') : $('td:contains(' + selectedState + ')')
                .closest('tr');
            var bannerRows = selectedBanner === 'all' ? $('tbody tr') : $('td:contains(' + selectedBanner + ')')
                .closest('tr');

            var matchingRows = stateRows.filter(function(index, row) {
                return $.inArray(row, bannerRows) !== -1;
            });

            if (matchingRows.length > 0) {
                matchingRows.show();
            } else {
                $('#busDataBody').append(
                    '<tr><td colspan="4" class="text-center">No data available in table</td></tr>');
            }
        }
    });

    $('#clearButton').on('click', function() {
        $('#stateName').val('');
        $('#bannerName').val('');
        $('tbody tr').show();
    });

    $('.uniqueImage').click(function() {
        var srcValue = $(this).attr('src');
        viewImage(srcValue);
    });

    $('#closeButton').click(function() {
        $('#all-sp-exception-dialogs').dialog('close');
    });

    function viewImage(imgUrl) {
        $('#all-sp-exception-dialogs').removeClass('hide');
        $('#uniquieImage2').attr('src', imgUrl);
        $('#all-sp-exception-dialogs').dialog({
            autoOpen: true,
            height: 266,
            width: 497,
            modal: true,
            resizable: false,
            close: function() {
                // Do something when the dialog is closed
                console.log("Dialog is closed");
            }
        });
    
    $('#downloadButton').on('click', function () {
    var selectedState = $('#stateName').val();
    var selectedBanner = $('#bannerName').val();

    // Filter data based on selected state and banner
    var filteredData = [];
    if (selectedState === 'all' && selectedBanner === 'all') {
        filteredData = $mergedData;
    } else {
        $mergedData.forEach(function (rowData, url) {
            if (selectedState === 'all' || rowData[0].stateName === selectedState) {
                if (selectedBanner === 'all' || url.includes(selectedBanner)) {
                    filteredData[url] = rowData;
                }
            }
        });
    }

    // Create Excel workbook
    var workbook = XLSX.utils.book_new();
    var worksheet = XLSX.utils.json_to_sheet(filteredData);

    // Add image to the worksheet
    var img = new Image();
    img.src = $('#uniquieImage2').attr('src');
    worksheet['!A1'] = { t: 's', v: img.src, f: '"image";"' + img.src + '"' };

    XLSX.utils.book_append_sheet(workbook, worksheet, 'FilteredData');

    // Save the Excel file
    XLSX.writeFile(workbook, 'FilteredData.xlsx');
});
}
   
</script>
</body>

</html>