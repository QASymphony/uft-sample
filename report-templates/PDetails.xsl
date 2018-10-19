<xsl:stylesheet version="1.0"
	xmlns:xsl = "http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="yes" />

<!-- ////////////  Match the document node, HTML, head, scripts  ////////////// -->

<!-- Controls if images are added to result. -->
<xsl:variable name="IncludeImages">1</xsl:variable>
<!-- rID attribute of first exported node (in case of exporting selection). Value 0 means that all nodes are exported. -->
<xsl:variable name="SelectionID">0</xsl:variable>

<!-- Remove this line for supporting MLU -->
<xsl:include href="PStringTable.xsl"/>
<!-- Add a new variable for supporting MLU -->
<xsl:variable name="StringTable">PStringTable.xsl</xsl:variable>

<!-- skip all the nodes before selection node and translate only selected branch -->
<xsl:template name="FindSelection">
	<xsl:choose>
		<xsl:when test="@rID and @rID=$SelectionID">
		<html>
			<head>
				<title><xsl:value-of select="//Report/General/@productName"/><xsl:copy-of select="$IDS_REPORT"/></title>
				<link rel="stylesheet" type="text/css" href="PResults.css" />
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			</head>
		<body>
			<xsl:apply-templates select="."/>
		</body>
		</html>
		</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="child::*">
				<xsl:call-template name="FindSelection"/>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match = "/">

<html >
	<head>
    	<title><xsl:value-of select="Report/General/@productName"/><xsl:copy-of select="$IDS_REPORT"/></title>
    	<link rel="stylesheet" type="text/css" href="PResults.css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   </head>
   <body bgcolor="#ffffff" leftmargin="0" marginwidth="20" topmargin="10" marginheight="10" vlink="#9966cc" >
      	<xsl:choose>
		<xsl:when test="$SelectionID=0">
      	<center>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="hl_qt">
				<div align="center"><span class="hl_qt"><xsl:value-of select="Report/General/@productName"/><xsl:copy-of select="$IDS_REPORT"/></span></div>
			</td>
		</tr>
		<tr>
			<td class="hl0">
				<xsl:choose>
					<xsl:when test="Report/BPT">
						<p><span class="hl0_name"><xsl:copy-of select="$IDS_BPT_COLON"/></span> <span class="hl0"><xsl:value-of select="Report/BPT/DName"/></span></p>
					</xsl:when>
					<xsl:when test="Report/Doc[@type='BC']">
						<p><span class="hl0_name"><xsl:copy-of select="$IDS_BC_COLON"/></span> <span class="hl0"><xsl:value-of select="Report/Doc/DName"/></span></p>
					</xsl:when>
					<xsl:otherwise>
						<p><span class="hl0_name"><xsl:copy-of select="$IDS_TEST_COLON"/></span> <span class="hl0"><xsl:value-of select="Report/Doc/DName"/></span></p>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</table>
			<br/>

	<xsl:choose>
		<xsl:when test="Report/BPT">
			<xsl:apply-templates select = "Report/BPT"  />	   
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select = "Report/Doc"  />	   
		</xsl:otherwise>
	</xsl:choose>
	
	</center>		
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="FindSelection"/>
		</xsl:otherwise>
	</xsl:choose>
   </body>
</html>


</xsl:template>





<xsl:template name="Arguments">

	<xsl:if test="Summary/Param[@paramInOut='In']">
		<table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
			<tr>
				<td bgcolor="white">
									
					<table border="0" cellpadding="3" cellspacing="0" width="100%">
						<tr>
							<td width="50%" valign="middle" align="center" class="tablehl"><b> <span class="tablehl"><xsl:copy-of select="$IDS_INPUT_PARAMETERS"/></span> </b></td>
							<td width="50%" valign="middle" align="center" class="tablehl"> <b><span class="tablehl"><xsl:copy-of select="$IDS_VALUE"/></span></b> </td>
						</tr>
						
						<tr>
							<td width="50%" height="1" class="bg_darkblue"></td>
							<td width="50%" height="1" class="bg_darkblue"></td>
						</tr>
	
						
						<xsl:for-each select="Summary/Param[@paramInOut='In']">
							<tr>
								<td width="50%" valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="ParamName"/></span></td>
								<td width="50%" valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="ParamVal"/></span></td>
							
								<tr>
									<td width="50%" class="bg_gray_eee" height="1"></td>
									<td width="50%" class="bg_gray_eee" height="1"></td>
								</tr>
							
							</tr>
						</xsl:for-each>
						<tr>
							<td width="50%" class="bg_gray_eee" height="1"></td>
							<td width="50%" class="bg_gray_eee" height="1"></td>
						</tr>
					</table>
				</td>
			</tr>
	<br/><br/>

		</table>
	
	</xsl:if>
	
	<xsl:if test="Summary/Param[@paramInOut='Out']">
		<table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
			<tr>
				<td bgcolor="white">
									
					<table border="0" cellpadding="3" cellspacing="0" width="100%">
						<tr>
							<td width="50%" valign="middle" align="center" class="tablehl"><b> <span class="tablehl"><xsl:copy-of select="$IDS_OUTPUT_PARAMETERS"/></span> </b></td>
							<td width="50%" valign="middle" align="center" class="tablehl"> <b><span class="tablehl"><xsl:copy-of select="$IDS_VALUE"/></span></b> </td>
						</tr>
						
						<tr>
							<td width="50%" height="1" class="bg_darkblue"></td>
							<td width="50%" height="1" class="bg_darkblue"></td>
						</tr>
	
						
						<xsl:for-each select="Summary/Param[@paramInOut='Out']">
							<tr>
								<td width="50%" valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="ParamName"/></span></td>
								<td width="50%" valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="ParamVal"/></span></td>
							
								<tr>
									<td width="50%" class="bg_gray_eee" height="1"></td>
									<td width="50%" class="bg_gray_eee" height="1"></td>
								</tr>
							
							</tr>
						</xsl:for-each>
						<tr>
							<td width="50%" class="bg_gray_eee" height="1"></td>
							<td width="50%" class="bg_gray_eee" height="1"></td>
						</tr>
					</table>
				</td>
			</tr>
	<br/><br/>
		</table>								
	</xsl:if>

</xsl:template>

<!-- ///////////////////////////////////////////////////////////// -->

<xsl:template match = "Obj|Details">
	<xsl:choose>
		<xsl:when test="@plainTxt ='False'">
			<xsl:value-of disable-output-escaping="yes" select="."/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="."/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<!-- //////////////////////////  Step  /////////////////////////////////// -->

<xsl:template match = "Step" >
	<table width="100%" valign="top" >
		<tr><td height="1" class="bg_midblue" /></tr>
		<tr>
			<td height="30">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><span class="hl1name"><xsl:copy-of select="$IDS_STEP_NAME_COLON"/></span><b><span class="hl1"><xsl:value-of select="NodeArgs/Disp"/></span></b></td>
						<td align="right">
							<span valign="center">
								<xsl:element name="span">
									<xsl:attribute name="class"><xsl:value-of select="NodeArgs/@status"/>High</xsl:attribute>
									<xsl:copy-of select="$IDS_STEP"/><xsl:value-of select="NodeArgs/@status"/>
								</xsl:element>
							</span>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td><br/></td></tr>
		<tr>
			<td>
				<table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
					<tr>
						<td bgcolor="white">
							<table border="0" cellpadding="3" cellspacing="0" width="100%">
								<tr align="center" border="0">
									<td width="25%" valign="middle" align="center" class="tablehl"><span width="100%" class="tablehl"><xsl:copy-of select="$IDS_OBJECT"/></span></td>
									<td width="25%" valign="middle" align="center" class="tablehl"><span width="100%" class="tablehl"><xsl:copy-of select="$IDS_DETAILS"/></span></td>
									<td width="25%" valign="middle" align="center" class="tablehl"><span width="100%" class="tablehl"><xsl:copy-of select="$IDS_RESULT"/></span></td>
									<td width="25%" valign="middle" align="center" class="tablehl"><span width="100%" class="tablehl"><xsl:copy-of select="$IDS_TIME"/></span></td>
								</tr>
								<tr>
									<td colspan="4" width="100%" height="1" class="bg_darkblue" />
								</tr>
								<tr border="0">
									<td valign="middle" align="center" height="20">
										<div align="center" width="100%" class="text">
											<xsl:apply-templates select="Obj"/>
										</div>
									</td>
									<td valign="middle" align="center" height="20">
										<div align="center" width="100%" class="text">
											<xsl:apply-templates select="Details"/>
										</div>
									</td>
									<td valign="middle" align="center" height="20">
										<div align="center" width="100%" class="text">
											<xsl:element name="span">
												<xsl:attribute name="class"><xsl:value-of select="NodeArgs/@status"/></xsl:attribute>
												<xsl:value-of select="NodeArgs/@status"/>
											</xsl:element>
										</div>
									</td>									
									<td valign="middle" align="center" height="20">
										<div align="center" width="100%" class="text"><xsl:value-of select="Time"/></div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

	<xsl:if test="$IncludeImages=1">
		<xsl:apply-templates select="NodeArgs"/>
	</xsl:if>

	<xsl:call-template name="GreenLine"/>
	<xsl:apply-templates select = "*[@rID]" />

</xsl:template>

<!-- ///////////////////////////////////////////////////////////// -->
<!-- Template for adding images -->

<xsl:template match="NodeArgs">

	<xsl:choose>
		<xsl:when test="(BtmPane/@vType = 'ViewerGen.SSViewerGen') and BtmPane/Path">
			<!-- add image for snapshot -->
			<center><img><xsl:attribute name="src"><xsl:value-of select="BtmPane/Path"/></xsl:attribute>
			<xsl:attribute name="alt">Screenshot</xsl:attribute>
			<xsl:attribute name="width">400</xsl:attribute>
			</img></center>
		</xsl:when>
		
		<xsl:when test="(BtmPane/@vType = 'Mercury.ACXSnapshotViewerObj') and BtmPane/Path and (substring(BtmPane/Path, string-length(BtmPane/Path)-2) = 'ini')">
			<!-- Add image(s) for bitmap checkpoint. We check that path extension is ini to distinguish bitmap checkpoint 
			from table checkpoint (that has inf extension). -->

			<xsl:choose>
				<!-- for failed bitmap checkpoint show three images -->
				<xsl:when test = "@status = 'Failed'">
			<table width="100%">
			<tr>
				<xsl:choose> 
					<xsl:when test = "not(BtmPane/@ShowDifference = 'False')">
						<td>
							<center>Expected:</center>
						</td>
					</xsl:when>
					<xsl:otherwise> 
						<td>
							<center>Source:</center>
						</td>
					</xsl:otherwise> 
				</xsl:choose> 
				<td>
					<center>Actual:</center>
				</td>
				<xsl:if test = "not(BtmPane/@ShowDifference = 'False')">
					<td>
						<center>Difference:</center>
					</td>
				</xsl:if>
			</tr>
			<tr>
				<td>
					<center>
					<img><xsl:attribute name="src"><xsl:value-of select="concat(BtmPane/Path,'.exp')"/></xsl:attribute>
							<xsl:attribute name="alt">Expected image</xsl:attribute>
					<xsl:attribute name="width">180</xsl:attribute>
					</img></center>
				</td>
	
				<td>
					<center><img><xsl:attribute name="src"><xsl:value-of select="concat(BtmPane/Path,'.act')"/></xsl:attribute>
							<xsl:attribute name="alt">Actual image</xsl:attribute>
					<xsl:attribute name="width">180</xsl:attribute>
					</img></center>
				</td>
				<xsl:if test = "not(BtmPane/@ShowDifference = 'False')">
					<td>
						<center><img><xsl:attribute name="src"><xsl:value-of select="concat(BtmPane/Path,'.dif')"/></xsl:attribute>
								<xsl:attribute name="alt">Difference image</xsl:attribute>
						<xsl:attribute name="width">180</xsl:attribute>
						</img></center>
					</td>
				</xsl:if>
			</tr>
			</table>
				</xsl:when>
				<xsl:otherwise>
					<!-- for passed bitmap checkpoint show one image -->
					<center><img><xsl:attribute name="src"><xsl:value-of select="concat(BtmPane/Path,'.act')"/></xsl:attribute>
					<xsl:attribute name="alt">Screenshot</xsl:attribute>
					<xsl:attribute name="width">400</xsl:attribute>
					</img></center>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		
		<!-- add step details for st export. Will return nothing for other test types -->
		<xsl:when test="(BtmPane/@vType = 'HTML') and BtmPane/Path">
			<!-- add image for snapshot -->
			<div>
				<center>
					<st>
						<xsl:value-of select="BtmPane/Path"/>
					</st>
				</center>
			</div>
			<!-- add placeholder for called (inner) test -->
			<xsl:if test="ExtendedInfo and ExtendedInfo/StepData">
				<div class="iteration_border">
					<center>
						<stInnerTest>
							<xsl:value-of select="ExtendedInfo/StepData"/>
						</stInnerTest>
					</center>
				</div>
			</xsl:if>
		</xsl:when>
		
		<!-- add placeholder for called (inner) test -->
		<xsl:when test="ExtendedInfo and ExtendedInfo/StepData">
			<div class="iteration_border">
				<center>
					<stInnerTest>
						<xsl:value-of select="ExtendedInfo/StepData"/>
					</stInnerTest>
				</center>
			</div>
		</xsl:when>
		
	</xsl:choose>
</xsl:template>

<!-- ///////////////////////////////////////////////////////////// -->

<xsl:template match="HtmlStep">
	<center>
	<table border = "1" bordercolor ="#666699" cellspacing="0" cellpadding="0" width="100%" height = "100" valign = "top" >
		<!--xsl:attribute name="id">Step<xsl:value-of select="@rID" /></xsl:attribute-->
		<tr><td>
		<div >
			<xsl:value-of disable-output-escaping="yes" select="HTML"/>	
		</div>
		</td></tr>		
	</table>
	</center>
	
	<xsl:if test="$IncludeImages=1">
		<xsl:apply-templates select="NodeArgs"/>
	</xsl:if>

	<xsl:call-template name="GreenLine"/>

	<xsl:apply-templates select = "*[@rID]" />
	
</xsl:template>


<!-- /////////////////////////// RunType ////////////////////////////////// -->

<xsl:template match="RunType">
	<span class="text"><b>
		<xsl:copy-of select="$IDS_UPDATE_RUN_COLON"/>
	
		<xsl:if test="@upDesc = 'True'"><xsl:copy-of select="$IDS_UPDATE_TO_PROPS" /></xsl:if>
		<xsl:if test="@upChk = 'True'">
			<xsl:if test="@upDesc = 'True'">,</xsl:if>
			<xsl:copy-of select="$IDS_UPDATE_CP_OV_PROPS" />
		</xsl:if>
		<xsl:if test="@upAS = 'True'">
			<xsl:if test="(@upDesc = 'True') or (@upChk = 'True')">,</xsl:if>
			<xsl:copy-of select="$IDS_UPDATE_ACTIVE_SCREEN" />
		</xsl:if>.
	</b></span>
</xsl:template>


<!-- ///////////////////////////////////////////////////////////// -->

<xsl:template match="AIter">


	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr><td class="iteration_head"><xsl:copy-of select="$IDS_ACTION_COLON"/> <xsl:value-of select="NodeArgs/Disp"/></td></tr>
		<tr>
			<td class="iteration_border" height="40">
				<table width="100%" border="0" cellspacing="2" cellpadding="0">
					<tr>
						<td>
							<div>
								<table border="0" cellpadding="3" cellspacing="0" width="100%">
									<tr><td height="1" class="bg_midblue"></td></tr>
									<tr>
										<td height="30">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td align="left" valign="top">
														<p><b><span class="hl1"><xsl:copy-of select="$IDS_ITERATION"/><xsl:value-of select="@iterID"/><xsl:copy-of select="$IDS_SUMMARY_COLON"/></span></b></p>
													</td>
												</tr>
												<tr><td height="10"></td>	</tr>
												<tr><td height="2" class="bg_darkblue"></td></tr>
												<tr><td height="20"></td>	</tr>
			
												<tr>
													<td align="left" valign="top">
														<p><b><span class="hl1"><xsl:copy-of select="$IDS_ITERATION"/> <xsl:value-of select="NodeArgs/@status"/></span></b></p>
													</td>
												</tr>
												<tr><td height="15"></td>	</tr>
											</table>
											<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#666699">
												<tr>
													<td bgcolor="white">
														<table border="0" cellpadding="3" cellspacing="0" width="100%">
															<tr>
																<td valign="middle" align="center" class="tablehl"><span class="tablehl"><xsl:copy-of select="$IDS_OBJECT"/></span></td>
																<td valign="middle" align="center" class="tablehl"><span class="tablehl"><xsl:copy-of select="$IDS_DETAILS"/></span></td>
																<td valign="middle" align="center" class="tablehl"><span class="tablehl"><xsl:copy-of select="$IDS_RESULT"/></span></td>
																<td valign="middle" align="center" class="tablehl"><span class="tablehl"><xsl:copy-of select="$IDS_TIME"/></span></td>
															</tr>
															<tr >
																<td  height="1" class="bg_darkblue"></td>
																<td  height="1" class="bg_darkblue"></td>
																<td  height="1" class="bg_darkblue"></td>
																<td  height="1" class="bg_darkblue"></td>
															</tr>
															<xsl:for-each select="Step|Action" >
																<tr>
																	<td valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="NodeArgs/Disp"/> </span></td>
																	<td  valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="Details"/></span></td>
																	<td  valign="middle" align="center" height="20">
																		<xsl:element name="span">
																			<xsl:attribute name="class"><xsl:value-of select="NodeArgs/@status"/></xsl:attribute>
																			<xsl:value-of select="NodeArgs/@status"/>
																		</xsl:element>
																	</td>
																	<td  valign="middle" align="center" height="20">
																		<span class="text">
																			<xsl:choose>
																				<xsl:when test="Time"><xsl:value-of select="Time"/></xsl:when>
																				<xsl:otherwise><xsl:value-of select="Summary/@sTime"/></xsl:otherwise>
																			</xsl:choose>
																		</span>
																	</td>
																</tr>	
																<tr>
																	<td height="1" class="bg_gray_eee"></td>
																	<td height="1" class="bg_gray_eee"></td>
																	<td height="1" class="bg_gray_eee"></td>
																	<td height="1" class="bg_gray_eee"></td>
																</tr>
															</xsl:for-each>
														</table>
													</td>
												</tr>
											</table>											
										</td>
									</tr>
								</table>						
								
				<xsl:call-template name="GreenLine"/>

				<xsl:apply-templates select = "*[@rID]" />
								
							</div>
						</td>
					</tr>
				</table>
			</td>		
		</tr>
	</table>
</xsl:template>



<!-- ///////////////////////////////////////////////////////////// -->

<xsl:template match="Action">
	<xsl:choose>
		<xsl:when test = "../@type = 'BC'">
			<xsl:apply-templates select = "*[@rID]" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="Action"/>
		</xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<xsl:template name="Action">

	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr><td class="action_head"><xsl:copy-of select="$IDS_ACTION_COLON"/> <xsl:value-of select="AName"/></td></tr>
		<tr>
			<td class="action_border" height="40">
				<table width="100%" border="0" cellspacing="2" cellpadding="0">
					<tr>
						<td>
							<div>
								<table border="0" cellpadding="3" cellspacing="0" width="100%">
									<tr><td height="1" class="bg_midblue"></td></tr>
									<tr>
										<td height="30">
											<p/><span class="hl1name"><xsl:value-of select="AName"/></span>
												<b><span class="hl1"><xsl:copy-of select="$IDS_RESULTS_SUMMARY"/></span></b>
										</td>
									</tr>
									<tr><td height="2" class="bg_darkblue"></td></tr>
									<tr><td height="20"></td>	</tr>
									<tr><td><span class="text"><b><xsl:copy-of select="$IDS_ACTION_COLON"/></b> <xsl:value-of select="AName"/> </span></td></tr>
									<tr>
										<td><span class="text"><b><xsl:copy-of select="$IDS_RUN_STARTED_COLON"/></b> <xsl:value-of select="Summary/@sTime"/></span></td>
									</tr>
									<tr>
										<td><span class="text"><b><xsl:copy-of select="$IDS_RUN_ENDED_COLON"/></b> <xsl:value-of select="Summary/@eTime"/></span></td>
									</tr>
									<tr><td height="15"></td></tr>
									<tr>
										<td><span class="text"><b><xsl:copy-of select="$IDS_RESULT_COLON"/></b><xsl:value-of select="NodeArgs/@status"/></span></td>
									</tr>
									<tr><td height="15"></td>	</tr>
								</table>
								<table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
									<tr>
										<td bgcolor="white">
											<table border="0" cellpadding="3" cellspacing="0" width="100%">
												<tr>
													<td width="50%" valign="middle" align="center" class="tablehl"><b> <span class="tablehl"><xsl:copy-of select="$IDS_STATUS"/></span> </b></td>
													<td width="50%" valign="middle" align="center" class="tablehl"> <b><span class="tablehl"><xsl:copy-of select="$IDS_TIMES"/></span></b> </td>
												</tr>
												<tr>
													<td width="50%" height="1" class="bg_darkblue"></td><td width="50%" height="1" class="bg_darkblue"></td>
												</tr>
												<tr>
													<td width="50%" valign="middle" align="center" height="20"><b><span class="passed"><xsl:copy-of select="$IDS_PASSED"/></span></b></td>
													<td width="50%" valign="middle" align="center" height="20">
														<span class="text"><xsl:value-of select="Summary/@passed"/></span>
													</td>
												</tr>
												<tr>
													<td width="50%" height="1" class="bg_gray_eee"></td>
													<td width="50%" height="1" class="bg_gray_eee"></td>
												</tr>
												<tr>
													<td width="50%" valign="middle" align="center" height="20"><span class="failed"><xsl:copy-of select="$IDS_FAILED"/></span></td>
													<td width="50%" valign="middle" align="center" height="20">
														<span class="text"><xsl:value-of select="Summary/@failed"/></span>
													</td>
												</tr>
												<tr>
													<td width="50%" class="bg_gray_eee" height="1"></td>
													<td width="50%" class="bg_gray_eee" height="1"></td>
												</tr>
												<tr>
													<td width="50%" valign="middle" align="center" height="20"><span class="warning"><span class="text"><b><xsl:copy-of select="$IDS_WARNINGS"/></b></span></span></td>
													<td width="50%" valign="middle" align="center" height="20">
														<span class="text"><xsl:value-of select="Summary/@warnings"/></span>
													</td>
												</tr>
												<tr>
													<td width="50%" class="bg_gray_eee" height="1"></td>
													<td width="50%" class="bg_gray_eee" height="1"></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
								
								<xsl:call-template name="Arguments"/>
								
								<xsl:call-template name="GreenLine"/>
				
								<xsl:apply-templates select = "*[@rID]" />
								
							</div>
						</td>
					</tr>
				</table>
			</td>		
		</tr>
	</table>
</xsl:template>

<xsl:template match="DT">
	<!--xsl:element name="IFRAME">
		<xsl:attribute name="src"><xsl:value-of select="NodeArgs/BtmPane/Path"/></xsl:attribute>
		<xsl:attribute name="width">100%</xsl:attribute>
		<xsl:attribute name="height">100%</xsl:attribute>
	</xsl:element-->
</xsl:template>

<!-- //////////////////////////// Test Iteration ///////////////////////////////// -->

<xsl:template match="DIter">

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr><td class="iteration_head"><xsl:copy-of select="$IDS_TEST_ITERATION"/><xsl:value-of select="@iterID"/></td>
		</tr>
		<tr>
			<td class="iteration_border">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td height="1" class="bg_midblue"></td>
								</tr>
								<tr>
									<td height="30">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
													<td align="left" valign="top">
														<p><b><span class="hl1"><xsl:copy-of select="$IDS_TEST_ITERATION"/><xsl:value-of select="@iterID"/><xsl:copy-of select="$IDS_SUMMARY_COLON"/></span></b></p>
													</td>
											
											</tr>
											<tr><td height="2"><br/>	</td></tr>
						
											<tr><td height="2" class="bg_darkblue"></td></tr>
											<tr><td height="20"><br/>	</td></tr>
														
											<tr>	
													<td align="left" valign="top">
														<p><b><span class="hl1"><xsl:copy-of select="$IDS_ITERATION"/><xsl:value-of select="NodeArgs/@status"/></span></b></p>
													</td>
											</tr>	
											<tr><td height="20"><br/>	</td></tr>
										</table>
									</td>
								</tr>
							</table>
							
							<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#666699">
								<tr>
									<td bgcolor="white">
										<table border="0" cellpadding="3" cellspacing="0" width="100%">
											<tr>
												<td valign="middle" align="center" class="tablehl"><span class="tablehl"><xsl:copy-of select="$IDS_OBJECT_TAB"/></span></td>
												<td valign="middle" align="center" class="tablehl"><span class="tablehl"><xsl:copy-of select="$IDS_DETAILS_TAB"/></span></td>
												<td valign="middle" align="center" class="tablehl"><span class="tablehl"><xsl:copy-of select="$IDS_RESULT_TAB"/></span></td>
												<td valign="middle" align="center" class="tablehl"><span class="tablehl"><xsl:copy-of select="$IDS_TIME_TAB"/></span></td>
											</tr>
											<tr >
												<td  height="1" class="bg_darkblue"></td>
												<td  height="1" class="bg_darkblue"></td>
												<td  height="1" class="bg_darkblue"></td>
												<td  height="1" class="bg_darkblue"></td>
											</tr>
											<xsl:for-each select="Step|Action" >
												<tr>
													<td valign="middle" align="center" height="20"><span class="text"><xsl:value-of select="NodeArgs/Disp"/> </span></td>
													<td  valign="middle" align="center" height="20">
														<span class="text">
															<xsl:choose>
															  <xsl:when test="self::node()/Details/@plainTxt='False'">
																<xsl:value-of disable-output-escaping="yes" select="Details"/>
															  </xsl:when>
															  <xsl:otherwise>
																<xsl:value-of disable-output-escaping="no" select="Details"/>
															  </xsl:otherwise>
															</xsl:choose>
														</span>
													</td>
													<td  valign="middle" align="center" height="20">
														<xsl:element name="span">
															<xsl:attribute name="class"><xsl:value-of select="NodeArgs/@status"/></xsl:attribute>
															<xsl:value-of select="NodeArgs/@status"/>
														</xsl:element>
													</td>
													<td  valign="middle" align="center" height="20">
														<span class="text">
															<xsl:choose>
																<xsl:when test="Time"><xsl:value-of select="Time"/></xsl:when>
																<xsl:otherwise><xsl:value-of select="Summary/@sTime"/></xsl:otherwise>
															</xsl:choose>
														</span>
													</td>
												</tr>	
												<tr>
													<td height="1" class="bg_gray_eee"></td>
													<td height="1" class="bg_gray_eee"></td>
													<td height="1" class="bg_gray_eee"></td>
													<td height="1" class="bg_gray_eee"></td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>

				<xsl:call-template name="GreenLine"/>

				<xsl:apply-templates select = "*[@rID]" />

			</td>	
		</tr>	
	</table>	
</xsl:template>


<!-- //////////////////////////// Doc  ///////////////////////////////// -->

<xsl:template match="Doc">
	<xsl:choose>
		<xsl:when test="@type = 'BC'">	
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr><td class="iteration_head" bgcolor="gray"><xsl:copy-of select="$IDS_BC"/><xsl:value-of select="DName"/>
				<xsl:if test="@BCIter">(Iteration <xsl:value-of select="@BCIter"/>) </xsl:if>
				</td></tr>				
				<tr>
					<td class="iteration_border">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								    <xsl:call-template name="Doc"/>
								</td>	
							</tr>	
						</table>	
					</td>
				</tr>
			</table>	
		</xsl:when>
		<xsl:when test="../General[@productName = 'WinRunner']">
			<xsl:choose>
				<xsl:when test="../@ver &lt; '3.0'">
					<xsl:apply-templates select = "*[@rID]" />
				</xsl:when>
				<xsl:otherwise>
						<xsl:call-template name="Doc"/>		
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="Doc"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="Doc">

	<table border="0" cellpadding="3" cellspacing="0" width="100%">
		<tr><td height="1" class="bg_midblue"></td></tr>
		<tr><td height="30"><p/><span class="hl1name"><xsl:value-of select="DName" /></span><b><span class="hl1"><xsl:copy-of select="$IDS_RESULTS_SUMMARY"/></span></b></td></tr>
		<tr><td height="2" class="bg_darkblue"></td></tr>
		<tr><td height="20"></td></tr>
		<tr><td><span class="text"><b>
					<xsl:choose>
						<xsl:when test="@type = 'BC'"><xsl:copy-of select="$IDS_BC_COLON"/></xsl:when>
						<xsl:otherwise><xsl:copy-of select="$IDS_TEST_COLON"/> </xsl:otherwise>
					</xsl:choose> </b> <xsl:value-of select="DName" /> 
				  </span>
		</td></tr>
		<xsl:if test="@productName">
			<tr><td><span class="text"><b><xsl:copy-of select="$IDS_PRODUCT_NAME_COLON"/></b> <xsl:value-of select="@productName" /></span></td></tr>
		</xsl:if>
    <tr><td><span class="text"><b><xsl:copy-of select="$IDS_PRODUCT_VERSION_COLON"/></b><xsl:value-of select="//Report/General/@productVer" /></span></td></tr>
		<tr><td><span class="text"><b><xsl:copy-of select="$IDS_RESULTS_NAME_COLON"/></b><xsl:value-of select="Res" /></span></td></tr>
		<tr><td><span class="text"><b><xsl:copy-of select="$IDS_TIME_ZONE_COLON"/></b><xsl:value-of select="//Report/@tmZone" /></span></td></tr>
    <tr><td><span class="text"><b><xsl:copy-of select="$IDS_HOST_NAME_COLON"/></b><xsl:value-of select="//Report/General/@host" /></span></td></tr>
    <tr><td><span class="text"><b><xsl:copy-of select="$IDS_OS_COLON"/></b><xsl:value-of select="//Report/General/@os" /></span></td></tr>
    <tr><td><span class="text"><b><xsl:copy-of select="$IDS_RUN_STARTED_COLON"/></b> <xsl:value-of select="Summary/@sTime" /></span></td></tr>
		<tr><td><span class="text"><b><xsl:copy-of select="$IDS_RUN_ENDED_COLON"/></b> <xsl:value-of select="Summary/@eTime" /></span></td></tr>
    <xsl:if test="//Report/General/@qcserver">
		  <tr><td><span class="text"><b><xsl:copy-of select="$IDS_QC_SERVER_COLON"/></b> <xsl:value-of select="//Report/General/@qcserver" /></span></td></tr>      
    </xsl:if>
    <xsl:if test="//Report/General/@qcproject">
		  <tr><td><span class="text"><b><xsl:copy-of select="$IDS_QC_PROJECT_COLON"/></b> <xsl:value-of select="//Report/General/@qcproject" /></span></td></tr>      
    </xsl:if>
		<tr><td><xsl:apply-templates select="RunType"/></td></tr>
		<xsl:if test="DVer">
			<tr><td><span class="text"><b><xsl:copy-of select="$IDS_TEST_VER_COLON"/></b> <xsl:value-of select="DVer" /></span></td></tr>
		</xsl:if>
		<xsl:if test="TSet">
			<tr><td><span class="text"><b><xsl:copy-of select="$IDS_TEST_SET_COLON"/></b> <xsl:value-of select="TSet" /></span></td></tr>
		</xsl:if>
		<xsl:if test="TInst">
			<tr><td><span class="text"><b><xsl:copy-of select="$IDS_TEST_INSTANCE_COLON"/></b> <xsl:value-of select="TInst" /></span><br/></td></tr>
		</xsl:if>
		
		<xsl:if test="@type = 'BC'"></xsl:if>
		<tr><td height="15"></td></tr>
		<tr><td><span class="text"><b><xsl:copy-of select="$IDS_RESULT_COLON"/></b> <xsl:value-of select="NodeArgs/@status"/></span></td></tr>
	
		<tr><td height="15"></td></tr>
		<xsl:if test="DIter">
			<tr><td>
				<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#666699">
					<tr><td bgcolor="white">
						<table border="0" cellpadding="2" cellspacing="0" width="100%">
							<tr>
								<td width="50%" valign="middle" align="center" class="tablehl"> <span class="tablehl"><xsl:copy-of select="$IDS_ITERATION_NUMBER"/></span> </td>
								<td width="50%" valign="middle" align="center" class="tablehl"> <span class="tablehl"><xsl:copy-of select="$IDS_RESULTS"/></span> </td>
							</tr>
							<tr>
								<td width="50%" height="1" class="bg_darkblue"></td>
								<td width="50%" height="1" class="bg_darkblue"></td>
							</tr>
							<tr>
								<td width="50%" height="1" class="bg_gray_eee"></td>
								<td width="50%" height="1" class="bg_gray_eee"></td>
							</tr>
							
							<xsl:for-each select="DIter">
								<tr>
									<td width="50%" valign="middle" align="center" height="20">
										<span class="text"><xsl:value-of select="@iterID"/></span>
									</td>
									<td width="50%" valign="middle" align="center" height="20">
										<xsl:element name="span">
											<xsl:attribute name="class"><xsl:value-of select="NodeArgs/@status"/></xsl:attribute>
											<xsl:value-of select="NodeArgs/@status"/>
										</xsl:element>
									</td>
								</tr>
								<tr>
									<td width="50%" height="1" class="bg_gray_eee"></td>
									<td width="50%" height="1" class="bg_gray_eee"></td>
								</tr>
								
							</xsl:for-each>
						</table>
					</td></tr>
				</table>
			</td></tr>
		</xsl:if>
	</table>
	
	<br/><br/>
	
	<table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
		<tr>
			<td bgcolor="white">
				<table border="0" cellpadding="3" cellspacing="0" width="100%">
					<tr>
						<td width="50%" valign="middle" align="center" class="tablehl"><b> <span class="tablehl"><xsl:copy-of select="$IDS_STATUS"/></span> </b></td>
						<td width="50%" valign="middle" align="center" class="tablehl"> <b><span class="tablehl"><xsl:copy-of select="$IDS_TIMES"/></span></b> </td>
					</tr>
					<tr>
						<td width="50%" height="1" class="bg_darkblue"></td><td width="50%" height="1" class="bg_darkblue"></td>
					</tr>
					<tr>
						<td width="50%" valign="middle" align="center" height="20"><b><span class="passed"><xsl:copy-of select="$IDS_PASSED"/></span></b></td>
						<td width="50%" valign="middle" align="center" height="20">
							<span class="text"><xsl:value-of select="Summary/@passed"/></span>
						</td>
					</tr>
					<tr>
						<td width="50%" height="1" class="bg_gray_eee"></td>
						<td width="50%" height="1" class="bg_gray_eee"></td>
					</tr>
					<tr>
						<td width="50%" valign="middle" align="center" height="20"><span class="failed"><xsl:copy-of select="$IDS_FAILED"/></span></td>
						<td width="50%" valign="middle" align="center" height="20">
							<span class="text"><xsl:value-of select="Summary/@failed"/></span>
						</td>
					</tr>
					<tr>
						<td width="50%" class="bg_gray_eee" height="1"></td>
						<td width="50%" class="bg_gray_eee" height="1"></td>
					</tr>
					<tr>
						<td width="50%" valign="middle" align="center" height="20"><span class="warning"><span class="text"><b><xsl:copy-of select="$IDS_WARNINGS"/></b></span></span></td>
						<td width="50%" valign="middle" align="center" height="20">
							<span class="text"><xsl:value-of select="Summary/@warnings"/></span>
						</td>
					</tr>
					<tr>
						<td width="50%" class="bg_gray_eee" height="1"></td>
						<td width="50%" class="bg_gray_eee" height="1"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
	<xsl:call-template name="Arguments"/>
	
	<xsl:call-template name="GreenLine"/>

	<xsl:apply-templates select = "*[@rID]" />
	

</xsl:template>


<!-- //////////////////////////// BPT  ///////////////////////////////// -->

<xsl:template match="BPT">

	<table border="0" cellpadding="3" cellspacing="0" width="100%">
		<tr><td height="1" class="bg_midblue"></td></tr>
		<tr><td height="30"><p/><span class="hl1name"><xsl:value-of select="DName" /></span><b><span class="hl1"><xsl:copy-of select="$IDS_RESULTS_SUMMARY"/></span></b></td></tr>
		<tr><td height="2" class="bg_darkblue"></td></tr>
		<tr><td height="20"></td></tr>
		<tr><td><span class="text"><b><xsl:copy-of select="$IDS_BPT_COLON"/> </b> <xsl:value-of select="DName" /> </span></td></tr>
		<tr><td><span class="text"><b><xsl:copy-of select="$IDS_RESULTS_NAME_COLON"/></b><xsl:value-of select="Res" /></span></td></tr>
		<tr><td><span class="text"><b><xsl:copy-of select="$IDS_TIME_ZONE_COLON"/></b><xsl:value-of select="//Report/@tmZone" /></span></td></tr>
		<tr><td><span class="text"><b><xsl:copy-of select="$IDS_RUN_STARTED_COLON"/></b> <xsl:value-of select="Doc[position()=1]/Summary/@sTime" /></span></td></tr>
		<tr><td><span class="text"><b><xsl:copy-of select="$IDS_RUN_ENDED_COLON"/></b> <xsl:value-of select="Doc[position()=last()]/Summary/@eTime" /></span></td></tr>
		<xsl:if test="DVer">
			<tr><td><span class="text"><b><xsl:copy-of select="$IDS_TEST_VER_COLON"/></b> <xsl:value-of select="DVer" /></span></td></tr>
		</xsl:if>
		<xsl:if test="TSet">
			<tr><td><span class="text"><b><xsl:copy-of select="$IDS_TEST_SET_COLON"/></b> <xsl:value-of select="TSet" /></span></td></tr>
		</xsl:if>
		<xsl:if test="TInst">
			<tr><td><span class="text"><b><xsl:copy-of select="$IDS_TEST_INSTANCE_COLON"/></b> <xsl:value-of select="TInst" /></span><br/></td></tr>
		</xsl:if>
		<tr><td height="15"></td></tr>
		<tr>
			<td>
				<span class="text"><b><xsl:copy-of select="$IDS_RESULT_COLON"/></b> 
					<xsl:choose>
						<xsl:when test="Doc/NodeArgs[@status = 'Failed']"><xsl:copy-of select="$IDS_FAILED"/></xsl:when>
						<xsl:when test="Doc/NodeArgs[@status = 'Warning']"><xsl:copy-of select="$IDS_WARNING"/></xsl:when>
						<xsl:when test="Doc/NodeArgs[@status = 'Passed']"><xsl:copy-of select="$IDS_PASSED"/></xsl:when>
						<xsl:otherwise><xsl:copy-of select="$IDS_DONE"/></xsl:otherwise>
					</xsl:choose>
				  </span>
			</td>
		</tr>
		<tr><td height="15"></td></tr>
		<xsl:if test="DIter">
			<tr><td>
				<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#666699">
					<tr><td bgcolor="white">
						<table border="0" cellpadding="2" cellspacing="0" width="100%">
							<tr>
								<td width="50%" valign="middle" align="center" class="tablehl"> <span class="tablehl"><xsl:copy-of select="$IDS_ITERATION_NUMBER"/></span> </td>
								<td width="50%" valign="middle" align="center" class="tablehl"> <span class="tablehl"><xsl:copy-of select="$IDS_RESULTS"/></span> </td>
							</tr>
							<tr>
								<td width="50%" height="1" class="bg_darkblue"></td>
								<td width="50%" height="1" class="bg_darkblue"></td>
							</tr>
							<tr>
								<td width="50%" height="1" class="bg_gray_eee"></td>
								<td width="50%" height="1" class="bg_gray_eee"></td>
							</tr>
							
							<xsl:for-each select="DIter">
								<tr>
									<td width="50%" valign="middle" align="center" height="20">
										<span class="text"><xsl:value-of select="@iterID"/></span>
									</td>
									<td width="50%" valign="middle" align="center" height="20">
										<xsl:element name="span">
											<xsl:attribute name="class"><xsl:value-of select="NodeArgs/@status"/></xsl:attribute>
											<xsl:value-of select="NodeArgs/@status"/>
										</xsl:element>
									</td>
								</tr>
								<tr>
									<td width="50%" height="1" class="bg_gray_eee"></td>
									<td width="50%" height="1" class="bg_gray_eee"></td>
								</tr>
								
							</xsl:for-each>
						</table>
					</td></tr>
				</table>
			</td></tr>
		</xsl:if>
	</table>
	
	<br/><br/>
	
	<table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="#666699">
		<tr>
			<td bgcolor="white">
				<table border="0" cellpadding="3" cellspacing="0" width="100%">
					<tr>
						<td width="50%" valign="middle" align="center" class="tablehl"><b> <span class="tablehl"><xsl:copy-of select="$IDS_STATUS"/></span> </b></td>
						<td width="50%" valign="middle" align="center" class="tablehl"> <b><span class="tablehl"><xsl:copy-of select="$IDS_TIMES"/></span></b> </td>
					</tr>
					<tr>
						<td width="50%" height="1" class="bg_darkblue"></td><td width="50%" height="1" class="bg_darkblue"></td>
					</tr>
					<tr>
						<td width="50%" valign="middle" align="center" height="20"><b><span class="passed"><xsl:copy-of select="$IDS_PASSED"/></span></b></td>
						<td width="50%" valign="middle" align="center" height="20">
							<span class="text"><xsl:value-of select="sum(Doc/Summary/@passed)"/></span>
						</td>
					</tr>
					<tr>
						<td width="50%" height="1" class="bg_gray_eee"></td>
						<td width="50%" height="1" class="bg_gray_eee"></td>
					</tr>
					<tr>
						<td width="50%" valign="middle" align="center" height="20"><span class="failed"><xsl:copy-of select="$IDS_FAILED"/></span></td>
						<td width="50%" valign="middle" align="center" height="20">
							<span class="text"><xsl:value-of select="sum(Doc/Summary/@failed)"/></span>
						</td>
					</tr>
					<tr>
						<td width="50%" class="bg_gray_eee" height="1"></td>
						<td width="50%" class="bg_gray_eee" height="1"></td>
					</tr>
					<tr>
						<td width="50%" valign="middle" align="center" height="20"><span class="warning"><span class="text"><b><xsl:copy-of select="$IDS_WARNINGS"/></b></span></span></td>
						<td width="50%" valign="middle" align="center" height="20">
							<span class="text"><xsl:value-of select="sum(Doc/Summary/@warnings)"/></span>
						</td>
					</tr>
					<tr>
						<td width="50%" class="bg_gray_eee" height="1"></td>
						<td width="50%" class="bg_gray_eee" height="1"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
	<xsl:call-template name="GreenLine"/>

	<xsl:apply-templates select = "*[@rID]" />

</xsl:template>




<!-- //////////////////////////// GreenLine ///////////////////////////////// -->

<xsl:template name="GreenLine">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="brake"> </td>
		</tr>
	</table>	
</xsl:template>

</xsl:stylesheet>

