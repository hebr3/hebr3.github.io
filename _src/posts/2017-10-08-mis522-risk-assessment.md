    Title: MIS522 - Rish Assessment
    Date: 2017-10-03T00:00:00
    Tags: Cybersecurity, MIS522
    Authors: Henry Brooks

Risk Assessment
---

This weeks we went over Risk Assessments guidelines posted by [The Federal Risk and Authorization Management Program](https://www.fedramp.gov/)(fedRAMP) and we were asked to use their [Security Assessment Report Template](https://www.fedramp.gov/resources/templates-2016/) to model as risk assessment for the university. 

fedRAMP lists 3 categories for the origination of threats

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg .tg-s6z2{text-align:center}
</style>
<table class="tg">
  <tr>
    <th class="tg-031e">Threat Origination Category</th>
    <th class="tg-s6z2">Type Identifier</th>
  </tr>
  <tr>
    <td class="tg-031e">Threat launched purposefully</td>
    <td class="tg-s6z2">P</td>
  </tr>
  <tr>
    <td class="tg-031e">Threats created by unintentional human or machine error</td>
    <td class="tg-s6z2">U</td>
  </tr>
  <tr>
    <td class="tg-031e">Threats caused by environmental agents or disruptions</td>
    <td class="tg-s6z2">E</td>
  </tr>
</table>

<!-- more -->

<br>
Potential threats are listed with their impact on confidentiality, integrity, and availability.

I have included the threats listed by fedRAMP that I feel are most relavent to CSUSM, and I have ordered them by their likelyhood considering the schools history and location.

<br>
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg .tg-baqh{text-align:center;vertical-align:top}
.tg .tg-yw4l{vertical-align:top}
</style>
<table class="tg">
  <tr>
    <th width="40px" class="tg-baqh">ID</th>
    <th class="tg-yw4l">Threat Name</th>
    <th class="tg-baqh">Type Identifier</th>
    <th class="tg-yw4l">Description</th>
    <th class="tg-baqh">Confidentiality</th>
    <th class="tg-baqh">Integrity</th>
    <th class="tg-baqh">Availability</th>
  </tr>
  <tr>
    <td class="tg-baqh">T-1</td>
    <td class="tg-yw4l">Phishing Attack</td>
    <td class="tg-baqh">P</td>
    <td class="tg-yw4l">Adversary attempts to acquire sensitive information such as usernames, passwords, or SSNs, by pretending to be communications from a legitimate/trustworthy source.<br>Typical attacks occur via email, instant messaging, or comparable means; commonly directing users to Web sites that appear to be legitimate sites, while actually stealing the entered information.Alteration of data, files, or records.</td>
    <td class="tg-baqh">Disclosure</td>
    <td class="tg-baqh">Modification or Destruction</td>
    <td class="tg-baqh">Denial of Service</td>
  </tr>
  <tr>
    <td class="tg-baqh">T-2</td>
    <td class="tg-yw4l">Unauthorized System Access</td>
    <td class="tg-baqh">P</td>
    <td class="tg-yw4l">An unauthorized user accesses a system or data.</td>
    <td class="tg-baqh">Disclosure</td>
    <td class="tg-baqh">Modification or Destruction</td>
    <td class="tg-baqh"></td>
  </tr>
  <tr>
    <td class="tg-baqh">T-3</td>
    <td class="tg-yw4l">Unauthorized Facility Access</td>
    <td class="tg-baqh">P</td>
    <td class="tg-yw4l">An unauthorized individual accesses a facility which may result in comprises of confidentiality, integrity, or availability.</td>
    <td class="tg-baqh">Disclosure</td>
    <td class="tg-baqh">Modification or Destruction</td>
    <td class="tg-baqh">Denial of Service</td>
  </tr>
  <tr>
    <td class="tg-baqh">T-4</td>
    <td class="tg-yw4l">Power Interruptions</td>
    <td class="tg-baqh">E</td>
    <td class="tg-yw4l">Power interruptions may be due to any number of reasons such as electrical grid failures, generator failures, uninterruptable power supply failures (e.g. spike, surge, brownout, or blackout).</td>
    <td class="tg-baqh"></td>
    <td class="tg-baqh"></td>
    <td class="tg-baqh">Denial of Service</td>
  </tr>
  <tr>
    <td class="tg-baqh">T-5</td>
    <td class="tg-yw4l">Procedural Error</td>
    <td class="tg-baqh">U</td>
    <td class="tg-yw4l">An error in procedures could result in unintended consequences.</td>
    <td class="tg-baqh">Disclosure</td>
    <td class="tg-baqh">Modification or Destruction</td>
    <td class="tg-baqh">Denial of Service</td>
  </tr>
  <tr>
    <td class="tg-baqh">T-6</td>
    <td class="tg-yw4l">Data Disclosure Attack</td>
    <td class="tg-baqh">P</td>
    <td class="tg-yw4l">An attacker uses techniques that could result in the disclosure of sensitive information by exploiting weaknesses in the design or configuration.</td>
    <td class="tg-baqh">Disclosure</td>
    <td class="tg-baqh"></td>
    <td class="tg-baqh"></td>
  </tr>
  <tr>
    <td class="tg-baqh">T-7</td>
    <td class="tg-yw4l">Sabotage</td>
    <td class="tg-baqh">P</td>
    <td class="tg-yw4l">Underhand interference with work.</td>
    <td class="tg-baqh"></td>
    <td class="tg-baqh">Modification or Destruction</td>
    <td class="tg-baqh">Denial of Service</td>
  </tr>
  <tr>
    <td class="tg-baqh">T-8</td>
    <td class="tg-yw4l">Fire</td>
    <td class="tg-baqh">E, P</td>
    <td class="tg-yw4l">Fire can be caused by arson, electrical problems, lightning, chemical agents, or other unrelated proximity fires.</td>
    <td class="tg-baqh"></td>
    <td class="tg-baqh">Destruction</td>
    <td class="tg-baqh">Denial of Service</td>
  </tr>
</table>